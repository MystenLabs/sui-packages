module 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::margin_math {
    public(friend) fun get_margin_left(arg0: 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::oiOpen(arg0);
        let v1 = if (0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::isPosPositive(arg0)) {
            0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::sub(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::margin(arg0) + v0 * arg1 / 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::compute_average_entry_price(arg0), v0)
        } else {
            0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::sub(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::margin(arg0) + v0, v0 * arg1 / 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::compute_average_entry_price(arg0))
        };
        0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::margin(arg0);
        if (0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::isPosPositive(arg0)) {
            0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::min(v0, 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::signed_number::positive_value(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::signed_number::add_uint(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::signed_number::from_subtraction(v0, 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::oiOpen(arg0)), 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_mul(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_mul(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::qPos(arg0), arg1), 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_uint() - 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::mro(arg0)))))
        } else {
            0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::min(v0, 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::sub(v0 + 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::oiOpen(arg0), 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_mul(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_mul(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::qPos(arg0), arg1), 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_uint() + 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_mul(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::qPos(arg0), arg2);
        if (0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::isPosPositive(arg0)) {
            0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::sub(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_div(v0, arg1) + 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::oiOpen(arg0), v0)
        } else {
            0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::sub(0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::library::base_div(v0, arg1) + v0, 0xc37ad78c8f1b9b09e6913117470dc85f68ad187c5f0d9b6d442728c21c320d59::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

