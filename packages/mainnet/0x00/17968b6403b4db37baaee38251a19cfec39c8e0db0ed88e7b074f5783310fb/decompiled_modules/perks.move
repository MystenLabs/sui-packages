module 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::perks {
    public(friend) fun reset_supply(arg0: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        let v0 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_mut_perk_supply_info(arg0, arg1);
        if (0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::can_reset_supply(v0, arg2)) {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::reset_supply(v0, arg2);
        };
    }

    public(friend) fun transfer_coin<T0>(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_faucet_holder_address(arg0));
    }

    public(friend) fun update_perk_description(arg0: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        validate_perk_name(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::update_perk_metadata_description(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadata>(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_id(arg0), arg1), arg2);
    }

    public(friend) fun update_supply(arg0: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::increase_supply(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_mut_perk_supply_info(arg0, arg1), arg2);
    }

    public(friend) fun validate_active_perk(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= *0x2::vec_map::get<0x1::string::String, u64>(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::borrow_player_perks(arg0), &arg1), 4);
    }

    public(friend) fun validate_perk_expired(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::Perk) {
        assert!(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_perk_expire_ts(arg0) == 0, 6);
    }

    public(friend) fun validate_perk_metadata(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String) {
        let v0 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_all_perks(arg0);
        assert!(!0x1::vector::contains<0x1::string::String>(&v0, &arg1), 5);
    }

    public(friend) fun validate_perk_name(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String) {
        let v0 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_all_perks(arg0);
        assert!(0x1::vector::contains<0x1::string::String>(&v0, &arg1), 1);
    }

    public(friend) fun validate_perk_price(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        assert!(arg3 != 0, 0);
        assert!(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_perk_price(arg0, arg1) * arg3 == arg2, 2);
    }

    public(friend) fun validate_protection_perk(arg0: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"attack_protection");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u64>(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::borrow_mut_player_perks(arg0), &v0);
        if (*v1 >= 0x2::clock::timestamp_ms(arg1)) {
            *v1 = 0;
        };
    }

    public(friend) fun validate_supply(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg1: 0x1::string::String) {
        assert!(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::is_supply_at_limit(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_perk_supply_info(arg0, arg1)), 3);
    }

    // decompiled from Move bytecode v6
}

