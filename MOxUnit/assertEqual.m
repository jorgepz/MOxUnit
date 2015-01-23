function assertEqual(a, b, message)
% assert that two inputs are equal
%
% assertEqual(a,b,[msg])
%
% Inputs:
%   a           first input  } of any
%   b           second input } type
%   msg             optional custom message
%
% Raises:
%   'moxunit:differentClass         a and b are of different class
%   'moxunit:differentSize'         a and b are of different size
%   'moxunit:differentSparsity'     a is sparse and b is not, or
%                                         vice versa
%   'moxunit:elementsNotEqual'      values in a and b are not equal
%
% Notes:
%   - If a custom message is provided, then any error message is prefixed
%     by this custom message
%   - This function attempts to show similar behaviour as in
%     Steve Eddins' MATLAB xUnit Test Framework (2009-2012)
%     URL: http://www.mathworks.com/matlabcentral/fileexchange/
%                           22846-matlab-xunit-test-framework
%
% NNO Jan 2014

    [error_id,whatswrong]=moxunit_util_elements_compatible(a,b);

    if isempty(error_id)
        if isequaln(a, b)
            return
        else
            whatswrong='elements are not equal';
            error_id='moxunit:elementsNotEqual';
        end
    end

    if nargin<3
        message='';
    end

    full_message=moxunit_util_input2str(message,whatswrong,a,b);

    if moxunit_util_platform_is_octave()
        error(error_id,full_message);
    else
        throwAsCaller(MException(error_id, full_message));
    end
