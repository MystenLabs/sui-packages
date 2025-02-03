module 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::margin_math {
    public(friend) fun get_margin_left(arg0: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(arg0);
        let v1 = if (0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(arg0)) {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::sub(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::margin(arg0) + v0 * arg1 / 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::compute_average_entry_price(arg0), v0)
        } else {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::sub(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::margin(arg0) + v0, v0 * arg1 / 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::compute_average_entry_price(arg0))
        };
        0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::margin(arg0);
        if (0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(arg0)) {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::min(v0, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::positive_value(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::add_uint(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::signed_number::from_subtraction(v0, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(arg0)), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_mul(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_mul(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(arg0), arg1), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_uint() - 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::mro(arg0)))))
        } else {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::min(v0, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::sub(v0 + 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(arg0), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_mul(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_mul(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(arg0), arg1), 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_uint() + 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_mul(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::qPos(arg0), arg2);
        if (0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::isPosPositive(arg0)) {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::sub(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_div(v0, arg1) + 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(arg0), v0)
        } else {
            0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::sub(0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::library::base_div(v0, arg1) + v0, 0x414cf9a236ddad23f0c46d999e8f1fbde6b19c008720e92c31699fc7783fdbce::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

