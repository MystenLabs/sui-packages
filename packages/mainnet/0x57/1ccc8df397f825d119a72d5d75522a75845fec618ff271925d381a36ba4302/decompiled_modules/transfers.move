module 0x571ccc8df397f825d119a72d5d75522a75845fec618ff271925d381a36ba4302::transfers {
    public(friend) fun assert_settleable<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(is_settleable<T0>(arg0), 1);
    }

    public(friend) fun is_settleable<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg0)) {
            let v1 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, 0) > 0;
            !v1
        } else {
            false
        }
    }

    public(friend) fun place_or_lock<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: T0, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap) {
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg0)) {
            0x2::kiosk::lock<T0>(arg3, arg4, arg0, arg2);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg1, arg3);
        } else {
            0x2::kiosk::place<T0>(arg3, arg4, arg2);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(arg3, arg1);
        };
    }

    public(friend) fun royalty_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg1)
        } else {
            0
        }
    }

    public(friend) fun settle_payment<T0, T1>(arg0: &mut 0x2::coin::Coin<T1>, arg1: &mut 0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::RoyaltyVault<T0, T1>, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::coin::value<T1>(arg0) >= arg4 + arg5 + arg6, 2);
        if (arg4 > 0) {
            0x2::coin::send_funds<T1>(0x2::coin::split<T1>(arg0, arg4, arg7), arg3);
        };
        if (arg5 > 0) {
            0x3d6bde09785d97970f9f12c399540f470ffa26f5f34a9dc1e0474882f0bf6750::royalty_vault::deposit<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg0, arg5, arg7)));
        };
        if (arg6 > 0) {
            0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg0, arg6, arg7))
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public(friend) fun transfer_to<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: T0, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg0);
        let v1 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg0);
        if (!v0 && !v1) {
            0x2::transfer::public_transfer<T0>(arg2, arg3);
            return 0x1::option::none<0x2::object::ID>()
        };
        let (v2, v3) = 0x2::kiosk::new(arg4);
        let v4 = v3;
        let v5 = v2;
        if (v0) {
            0x2::kiosk::lock<T0>(&mut v5, &v4, arg0, arg2);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg1, &v5);
        } else {
            0x2::kiosk::place<T0>(&mut v5, &v4, arg2);
        };
        if (v1) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v5, v4, arg3, arg4);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v5, arg1);
        } else {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, arg3);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(&v5))
    }

    public(friend) fun zero_purchase<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert_settleable<T0>(arg2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let v2 = v1;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        };
        (v0, v2)
    }

    // decompiled from Move bytecode v7
}

