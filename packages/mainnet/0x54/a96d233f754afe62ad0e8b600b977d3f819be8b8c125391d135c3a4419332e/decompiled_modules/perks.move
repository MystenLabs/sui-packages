module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks {
    public(friend) fun reset_supply(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_mut_perk_supply_info(arg0, arg1);
        if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::can_reset_supply(v0, arg2)) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::reset_supply(v0, arg2);
        };
    }

    public(friend) fun transfer_coin<T0>(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_faucet_holder_address(arg0));
    }

    public(friend) fun update_supply(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::increase_supply(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_mut_perk_supply_info(arg0, arg1), arg2);
    }

    public(friend) fun validate_active_perk(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_perks(arg0);
        let v1 = if (0x2::vec_map::contains<0x1::string::String, u64>(v0, &arg1)) {
            *0x2::vec_map::get<0x1::string::String, u64>(v0, &arg1)
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(v0, arg1, 0);
            0
        };
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 4);
    }

    public(friend) fun validate_perk_cooldown(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_timers(arg0);
        if (0x2::vec_map::contains<0x1::string::String, u64>(v0, &arg3)) {
            assert!(0x2::clock::timestamp_ms(arg5) >= *0x2::vec_map::get<0x1::string::String, u64>(v0, &arg3), 6);
            *0x2::vec_map::get_mut<0x1::string::String, u64>(v0, &arg3) = 0x2::clock::timestamp_ms(arg5) + arg4 + 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_value(arg1, arg2);
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(v0, arg3, 0x2::clock::timestamp_ms(arg5) + arg4 + 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_value(arg1, arg2));
        };
    }

    public(friend) fun validate_perk_metadata(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x1::string::String) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_all_perks(arg0);
        assert!(!0x1::vector::contains<0x1::string::String>(&v0, &arg1), 5);
    }

    public(friend) fun validate_perk_name(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x1::string::String) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_all_perks(arg0);
        assert!(0x1::vector::contains<0x1::string::String>(&v0, &arg1), 1);
    }

    public(friend) fun validate_perk_price(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        assert!(arg3 != 0, 0);
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_perk_price(arg0, arg1) * arg3 == arg2, 2);
    }

    public(friend) fun validate_protection_perk(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"attack_protection");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u64>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_perks(arg0), &v0);
        if (*v1 >= 0x2::clock::timestamp_ms(arg1)) {
            *v1 = 0;
        };
    }

    public(friend) fun validate_supply(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg1: 0x1::string::String) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::is_supply_at_limit(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_perk_supply_info(arg0, arg1)), 3);
    }

    // decompiled from Move bytecode v6
}

