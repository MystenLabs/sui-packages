module 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::airdrop {
    public entry fun aidrop_to(arg0: &0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::RegisterAdminCap, arg1: &mut 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::Registry, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<address, 0x2::kiosk::Kiosk>();
        let v1 = 0x2::vec_map::empty<address, 0x2::kiosk::KioskOwnerCap>();
        let v2 = 0;
        loop {
            if (v2 == 0x1::vector::length<address>(&arg5)) {
                break
            };
            let v3 = *0x1::vector::borrow<address>(&arg5, v2);
            let v4 = 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::get_minted(arg1, 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::airdrop(arg1));
            0x2::kiosk::list<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(arg4, arg3, v4, 0);
            let (v5, v6) = 0x2::kiosk::purchase<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(arg4, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
            let v7 = v6;
            if (!0x2::vec_map::contains<address, 0x2::kiosk::Kiosk>(&v0, &v3)) {
                let (v8, v9) = 0x2::kiosk::new(arg6);
                0x2::vec_map::insert<address, 0x2::kiosk::Kiosk>(&mut v0, v3, v8);
                0x2::vec_map::insert<address, 0x2::kiosk::KioskOwnerCap>(&mut v1, v3, v9);
            };
            let v10 = 0x2::vec_map::get_mut<address, 0x2::kiosk::Kiosk>(&mut v0, &v3);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(arg2, &mut v7, 0x2::coin::zero<0x2::sui::SUI>(arg6));
            0x2::kiosk::lock<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(v10, 0x2::vec_map::get<address, 0x2::kiosk::KioskOwnerCap>(&v1, &v3), arg2, v5);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(&mut v7, v10);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(arg2, v7);
            v2 = v2 + 1;
        };
        while (!0x2::vec_map::is_empty<address, 0x2::kiosk::Kiosk>(&v0)) {
            let (v14, v15) = 0x2::vec_map::pop<address, 0x2::kiosk::Kiosk>(&mut v0);
            let (_, v17) = 0x2::vec_map::pop<address, 0x2::kiosk::KioskOwnerCap>(&mut v1);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v15);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v17, v14);
        };
        0x2::vec_map::destroy_empty<address, 0x2::kiosk::Kiosk>(v0);
        0x2::vec_map::destroy_empty<address, 0x2::kiosk::KioskOwnerCap>(v1);
    }

    public entry fun premint_to_kiosk(arg0: &0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::RegisterAdminCap, arg1: &mut 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::Registry, arg2: &0x2::transfer_policy::TransferPolicy<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::total_supply(arg1) + arg5 <= 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::collection_max_supply(arg1), 13906834307487367169);
        let v0 = 0;
        loop {
            if (v0 == arg5) {
                break
            };
            let v1 = 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::mint(arg1, arg6);
            0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::registry::add_minted(arg1, 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::serial_number(&v1), 0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::get_id(&v1));
            0x2::kiosk::lock<0x62c6963357419ab135aa060e2ad2efca9eb663e8e8bd5d23191a5860bb193267::suiball::Suiball>(arg4, arg3, arg2, v1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

