module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::clearing {
    public(friend) fun clear<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::kiosk::Kiosk, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1));
            v0 = v1;
            assert!(0x2::balance::value<0x2::sui::SUI>(arg3) >= v1, 31);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg0, arg1, 0x2::coin::take<0x2::sui::SUI>(arg3, v1, arg4));
        };
        if (needs_lock<T0>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg1, arg2);
        };
        if (needs_personal<T0>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(arg2, arg1);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg0, arg1);
        };
        v0
    }

    public fun needs_lock<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg0)
    }

    public fun needs_personal<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg0)
    }

    public fun royalty_due<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg1)
        } else {
            0
        }
    }

    public fun settle_into<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: T0, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        stow<T0>(arg3, arg4, arg0, arg2);
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg5);
        clear<T0>(arg0, arg1, arg3, v0, arg6)
    }

    public(friend) fun stow<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0) {
        if (needs_lock<T0>(arg2)) {
            0x2::kiosk::lock<T0>(arg0, arg1, arg2, arg3);
        } else {
            0x2::kiosk::place<T0>(arg0, arg1, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

