module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_gameplay_items {
    struct PowerUp<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Theme<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Environment<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Vehicle<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Avatar<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Equipable<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Player<phantom T0> has drop {
        dummy_field: bool,
    }

    struct GadgetGameplayItem<phantom T0> has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        level: u16,
        rank: u16,
        rarity: 0x1::string::String,
        enhancement: 0x1::string::String,
        media_url_primary: 0x1::string::String,
        media_url_display: 0x1::string::String,
        metadata: 0x2::object::ID,
        mint_number: u64,
    }

    struct GadgetGameplayItemMetadata<phantom T0> has key {
        id: 0x2::object::UID,
        version: u16,
        mint_supply: 0x1::option::Option<u64>,
        current_supply: u64,
        ig_coin_price: 0x2::vec_map::VecMap<u16, u64>,
        ig_gem_price: 0x2::vec_map::VecMap<u16, u64>,
        gbucks_price: 0x2::vec_map::VecMap<u16, u64>,
        game: 0x1::option::Option<0x1::string::String>,
        description: 0x1::string::String,
        rarity: 0x2::vec_map::VecMap<u16, 0x1::string::String>,
        enhancements: 0x2::vec_map::VecMap<u16, 0x1::string::String>,
        episode_utility: 0x1::option::Option<u64>,
        transferability: 0x1::string::String,
        royalty: u16,
        unlock_currency: 0x1::option::Option<0x1::string::String>,
        unlock_threshold: 0x2::vec_map::VecMap<u16, u64>,
        edition: 0x1::option::Option<0x1::string::String>,
        set: 0x1::option::Option<0x1::string::String>,
        upgradeable: bool,
        media_urls_primary: 0x2::vec_map::VecMap<u16, 0x1::string::String>,
        media_urls_display: 0x2::vec_map::VecMap<u16, 0x1::string::String>,
        ranks: 0x2::vec_map::VecMap<u16, u16>,
        sub_type: 0x1::string::String,
        season: 0x1::option::Option<u16>,
    }

    public fun transfer<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::TransferCap, arg1: GadgetGameplayItem<T0>, arg2: &GadgetGameplayItemMetadata<T0>, arg3: address) {
        assert!(arg2.transferability == 0x1::string::utf8(b"Platform"), 3);
        0x2::transfer::transfer<GadgetGameplayItem<T0>>(arg1, arg3);
    }

    fun add_internal<T0>(arg0: &mut 0x2::vec_map::VecMap<u16, T0>, arg1: u16, arg2: T0) {
        0x2::vec_map::insert<u16, T0>(arg0, arg1, arg2);
    }

    fun create_vecmap<T0: copy + drop>(arg0: vector<u16>, arg1: vector<T0>) : 0x2::vec_map::VecMap<u16, T0> {
        let v0 = 0x1::vector::length<u16>(&arg0);
        assert!(v0 == 0x1::vector::length<T0>(&arg1), 5);
        let v1 = 0x2::vec_map::empty<u16, T0>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &mut v1;
            add_internal<T0>(v3, *0x1::vector::borrow<u16>(&arg0, v2), *0x1::vector::borrow<T0>(&arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun level<T0>(arg0: &GadgetGameplayItem<T0>) : &u16 {
        &arg0.level
    }

    public fun mint_and_transfer<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut GadgetGameplayItemMetadata<T0>, arg2: 0x1::string::String, arg3: u16, arg4: 0x2::object::ID, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.current_supply;
        if (0x1::option::is_some<u64>(&arg1.mint_supply)) {
            assert!(v0 < *0x1::option::borrow<u64>(&arg1.mint_supply), 2);
        };
        let v1 = GadgetGameplayItem<T0>{
            id                : 0x2::object::new(arg6),
            title             : arg2,
            level             : arg3,
            rank              : *0x2::vec_map::get<u16, u16>(&arg1.ranks, &arg3),
            rarity            : *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.rarity, &arg3),
            enhancement       : *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.enhancements, &arg3),
            media_url_primary : *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.media_urls_primary, &arg3),
            media_url_display : *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.media_urls_display, &arg3),
            metadata          : arg4,
            mint_number       : v0 + 1,
        };
        0x2::transfer::transfer<GadgetGameplayItem<T0>>(v1, arg5);
    }

    public fun mint_metadata<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: u16, arg2: vector<u16>, arg3: 0x1::option::Option<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: 0x1::option::Option<u64>, arg12: 0x1::string::String, arg13: u16, arg14: 0x1::option::Option<0x1::string::String>, arg15: vector<u64>, arg16: 0x1::option::Option<0x1::string::String>, arg17: 0x1::option::Option<0x1::string::String>, arg18: bool, arg19: vector<0x1::string::String>, arg20: vector<0x1::string::String>, arg21: vector<u16>, arg22: 0x1::string::String, arg23: 0x1::option::Option<u16>, arg24: &mut 0x2::tx_context::TxContext) {
        let v0 = GadgetGameplayItemMetadata<T0>{
            id                 : 0x2::object::new(arg24),
            version            : arg1,
            mint_supply        : arg3,
            current_supply     : 0,
            ig_coin_price      : create_vecmap<u64>(arg2, arg4),
            ig_gem_price       : create_vecmap<u64>(arg2, arg5),
            gbucks_price       : create_vecmap<u64>(arg2, arg6),
            game               : arg7,
            description        : arg8,
            rarity             : create_vecmap<0x1::string::String>(arg2, arg9),
            enhancements       : create_vecmap<0x1::string::String>(arg2, arg10),
            episode_utility    : arg11,
            transferability    : arg12,
            royalty            : arg13,
            unlock_currency    : arg14,
            unlock_threshold   : create_vecmap<u64>(arg2, arg15),
            edition            : arg16,
            set                : arg17,
            upgradeable        : arg18,
            media_urls_primary : create_vecmap<0x1::string::String>(arg2, arg19),
            media_urls_display : create_vecmap<0x1::string::String>(arg2, arg20),
            ranks              : create_vecmap<u16>(arg2, arg21),
            sub_type           : arg22,
            season             : arg23,
        };
        0x2::transfer::share_object<GadgetGameplayItemMetadata<T0>>(v0);
    }

    public fun update_price<T0>(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut GadgetGameplayItemMetadata<T0>, arg2: 0x1::string::String, arg3: u16, arg4: u64) {
        let v0 = if (arg2 == 0x1::string::utf8(b"G_BUCKS")) {
            0x2::vec_map::get_mut<u16, u64>(&mut arg1.gbucks_price, &arg3)
        } else if (arg2 == 0x1::string::utf8(b"GADGET_COIN")) {
            0x2::vec_map::get_mut<u16, u64>(&mut arg1.ig_coin_price, &arg3)
        } else {
            assert!(arg2 == 0x1::string::utf8(b"GADGET_GEM"), 0);
            0x2::vec_map::get_mut<u16, u64>(&mut arg1.ig_gem_price, &arg3)
        };
        *v0 = arg4;
    }

    public fun upgrade_gameplay_item<T0, T1>(arg0: &mut GadgetGameplayItem<T0>, arg1: &GadgetGameplayItemMetadata<T0>, arg2: 0x2::token::Token<T1>, arg3: &mut 0x2::token::TokenPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.upgradeable == true, 4);
        let v0 = level<T0>(arg0);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (v1 == 0x1::type_name::get<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>()) {
            *0x2::vec_map::get<u16, u64>(&arg1.gbucks_price, v0)
        } else if (v1 == 0x1::type_name::get<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_coin::GADGET_COIN>()) {
            *0x2::vec_map::get<u16, u64>(&arg1.ig_coin_price, v0)
        } else {
            assert!(v1 == 0x1::type_name::get<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_gem::GADGET_GEM>(), 0);
            *0x2::vec_map::get<u16, u64>(&arg1.ig_gem_price, v0)
        };
        assert!(0x2::token::value<T1>(&arg2) == v2, 1);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T1>(arg3, 0x2::token::spend<T1>(arg2, arg4), arg4);
        arg0.level = *v0 + 1;
        arg0.rank = *0x2::vec_map::get<u16, u16>(&arg1.ranks, &arg0.level);
        arg0.enhancement = *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.enhancements, &arg0.level);
        arg0.media_url_primary = *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.media_urls_primary, &arg0.level);
        arg0.media_url_display = *0x2::vec_map::get<u16, 0x1::string::String>(&arg1.media_urls_display, &arg0.level);
    }

    // decompiled from Move bytecode v6
}

