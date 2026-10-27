module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::courier {
    struct Courier has drop {
        dummy_field: bool,
    }

    public fun enable(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::kiosk_extension::is_installed<Courier>(arg0)) {
            let v0 = Courier{dummy_field: false};
            0x2::kiosk_extension::add<Courier>(v0, arg0, arg1, 3, arg2);
        } else if (!0x2::kiosk_extension::is_enabled<Courier>(arg0)) {
            0x2::kiosk_extension::enable<Courier>(arg0, arg1);
        };
    }

    public(friend) fun deliver<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: T0, arg3: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(0x2::kiosk::owner(arg0) == arg1, 802);
        assert!(ready(arg0), 801);
        if (0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::needs_lock<T0>(arg3)) {
            let v0 = Courier{dummy_field: false};
            0x2::kiosk_extension::lock<Courier, T0>(v0, arg0, arg2, arg3);
        } else {
            let v1 = Courier{dummy_field: false};
            0x2::kiosk_extension::place<Courier, T0>(v1, arg0, arg2, arg3);
        };
    }

    public(friend) fun deliver_fresh<T0: store + key>(arg0: address, arg1: T0, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::transfer_policy::TransferRequest<T0>, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::set_owner_custom(&mut v3, &v2, arg0);
        let v4 = &mut v3;
        enable(v4, &v2, arg5);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::stow<T0>(&mut v3, &v2, arg2, arg1);
        if (0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::needs_personal<T0>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v3, v2, arg0, arg5);
        } else {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg0);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v3), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::clear<T0>(arg2, arg3, &v3, arg4, arg5))
    }

    public fun open(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        enable(v4, &v2, arg1);
        if (arg0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v3, v2, 0x2::tx_context::sender(arg1), arg1);
        } else {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::object::id<0x2::kiosk::Kiosk>(&v3)
    }

    public fun ready(arg0: &0x2::kiosk::Kiosk) : bool {
        0x2::kiosk_extension::is_installed<Courier>(arg0) && 0x2::kiosk_extension::can_lock<Courier>(arg0)
    }

    // decompiled from Move bytecode v7
}

