module 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::airdrop {
    public entry fun aidrop_to(arg0: &0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::RegisterAdminCap, arg1: &mut 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::Registry, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<address, 0x2::kiosk::Kiosk>();
        let v1 = 0x2::vec_map::empty<address, 0x2::kiosk::KioskOwnerCap>();
        let v2 = 0;
        loop {
            if (v2 == 0x1::vector::length<address>(&arg5)) {
                break
            };
            let v3 = *0x1::vector::borrow<address>(&arg5, v2);
            let v4 = 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::get_minted(arg1, 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::airdrop(arg1));
            0x2::kiosk::list<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(arg4, arg3, v4, 0);
            let (v5, v6) = 0x2::kiosk::purchase<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(arg4, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
            let v7 = v6;
            if (!0x2::vec_map::contains<address, 0x2::kiosk::Kiosk>(&v0, &v3)) {
                let (v8, v9) = 0x2::kiosk::new(arg6);
                0x2::vec_map::insert<address, 0x2::kiosk::Kiosk>(&mut v0, v3, v8);
                0x2::vec_map::insert<address, 0x2::kiosk::KioskOwnerCap>(&mut v1, v3, v9);
            };
            let v10 = 0x2::vec_map::get_mut<address, 0x2::kiosk::Kiosk>(&mut v0, &v3);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(arg2, &mut v7, 0x2::coin::zero<0x2::sui::SUI>(arg6));
            0x2::kiosk::lock<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(v10, 0x2::vec_map::get<address, 0x2::kiosk::KioskOwnerCap>(&v1, &v3), arg2, v5);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(&mut v7, v10);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(arg2, v7);
            v2 = v2 + 1;
        };
        let v14 = 0;
        loop {
            if (v14 == 0x1::vector::length<address>(&arg5)) {
                break
            };
            let v15 = *0x1::vector::borrow<address>(&arg5, v2);
            let (_, v17) = 0x2::vec_map::remove<address, 0x2::kiosk::Kiosk>(&mut v0, &v15);
            let (_, v19) = 0x2::vec_map::remove<address, 0x2::kiosk::KioskOwnerCap>(&mut v1, &v15);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v17);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v19, v15);
            v14 = v14 + 1;
        };
        0x2::vec_map::destroy_empty<address, 0x2::kiosk::Kiosk>(v0);
        0x2::vec_map::destroy_empty<address, 0x2::kiosk::KioskOwnerCap>(v1);
    }

    public entry fun premint_to_kiosk(arg0: &0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::RegisterAdminCap, arg1: &mut 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::Registry, arg2: &0x2::transfer_policy::TransferPolicy<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::total_supply(arg1) + arg5 <= 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::collection_max_supply(arg1), 13906834307487367169);
        let v0 = 0;
        loop {
            if (v0 == arg5) {
                break
            };
            let v1 = 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::mint(arg1, arg6);
            0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::registry::add_minted(arg1, 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::serial_number(&v1), 0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::get_id(&v1));
            0x2::kiosk::lock<0xadac10a1f8d778b73de6729956b4294ab1162d5e24370109823aacc9ce1776aa::suiball::Suiball>(arg4, arg3, arg2, v1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

