module 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft {
    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct LevelInfoKey<phantom T0> has copy, drop, store {
        level_name: vector<u8>,
    }

    struct LevelInfoValue<phantom T0> has copy, drop, store {
        mint_price: u64,
        level_value: u64,
        next_level_value: u64,
        next_level_name: vector<u8>,
        rarity_numerator: u64,
        rarity_denumerator: u64,
    }

    struct UserInfo has store {
        is_mint: bool,
    }

    struct XYZNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
        level: 0x1::string::String,
    }

    struct MintingTreasury has store, key {
        id: 0x2::object::UID,
        current_mint: u64,
        max_total: u64,
        due_time: u64,
        beneficiary: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mint_ref_percent: 0x1::fixed_point32::FixedPoint32,
        ref_pool_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public(friend) fun add_level_price_info<T0>(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64) {
        assert!(arg2 > 0 && arg6 > 0 && arg7 > 0 && arg4 > 0 && arg7 >= arg6, 8);
        let v0 = LevelInfoKey<T0>{level_name: arg3};
        assert!(!0x2::dynamic_field::exists_with_type<LevelInfoKey<T0>, LevelInfoValue<T0>>(&arg1.id, v0), 3);
        let v1 = LevelInfoKey<T0>{level_name: arg3};
        let v2 = LevelInfoValue<T0>{
            mint_price         : arg2,
            level_value        : arg4,
            next_level_value   : arg4 + 1,
            next_level_name    : arg5,
            rarity_numerator   : arg6,
            rarity_denumerator : arg7,
        };
        0x2::dynamic_field::add<LevelInfoKey<T0>, LevelInfoValue<T0>>(&mut arg1.id, v1, v2);
    }

    public fun burn(arg0: XYZNFT) {
        let XYZNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            level       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_cap(arg0: MinterCap) {
        let MinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun collect_profits(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.beneficiary == v0, 12);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.ref_pool_balance);
        if (v1 > 0 && 0x2::clock::timestamp_ms(arg2) > arg1.due_time) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.ref_pool_balance, v1, arg3), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg3), v0);
    }

    public fun creator(arg0: &XYZNFT) : &address {
        &arg0.creator
    }

    public(friend) fun delete_level_price_info<T0>(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: vector<u8>) {
        let v0 = LevelInfoKey<T0>{level_name: arg2};
        assert!(0x2::dynamic_field::exists_with_type<LevelInfoKey<T0>, LevelInfoValue<T0>>(&arg1.id, v0), 2);
        let v1 = LevelInfoKey<T0>{level_name: arg2};
        0x2::dynamic_field::remove<LevelInfoKey<T0>, LevelInfoValue<T0>>(&mut arg1.id, v1);
    }

    public(friend) fun deposit_to_ref_pool(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.ref_pool_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun description(arg0: &XYZNFT) : &0x1::string::String {
        &arg0.description
    }

    public(friend) fun edit_level_price_info<T0>(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64) {
        assert!(arg2 > 0 && arg6 > 0 && arg7 > 0 && arg4 > 0 && arg7 >= arg6, 8);
        let v0 = LevelInfoKey<T0>{level_name: arg3};
        assert!(0x2::dynamic_field::exists_with_type<LevelInfoKey<T0>, LevelInfoValue<T0>>(&arg1.id, v0), 2);
        let v1 = LevelInfoValue<T0>{
            mint_price         : arg2,
            level_value        : arg4,
            next_level_value   : arg4 + 1,
            next_level_name    : arg5,
            rarity_numerator   : arg6,
            rarity_denumerator : arg7,
        };
        let v2 = LevelInfoKey<T0>{level_name: arg3};
        *0x2::dynamic_field::borrow_mut<LevelInfoKey<T0>, LevelInfoValue<T0>>(&mut arg1.id, v2) = v1;
    }

    public(friend) fun free_mint_to_account(arg0: &mut MintingTreasury, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.due_time, 1);
        let v0 = LevelInfoKey<0x2::sui::SUI>{level_name: b"level_one"};
        assert!(0x2::dynamic_field::exists_with_type<LevelInfoKey<0x2::sui::SUI>, LevelInfoValue<0x2::sui::SUI>>(&arg0.id, v0), 2);
        assert!(arg0.max_total > arg0.current_mint, 9);
        let v1 = 0x2::tx_context::sender(arg2);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v1)) {
            let v2 = UserInfo{is_mint: false};
            0x2::dynamic_field::add<address, UserInfo>(&mut arg0.id, v1, v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v1);
        assert!(!v3.is_mint, 5);
        let v4 = 0x1::string::utf8(b"FLORENTINO NFT #");
        0x1::string::append(&mut v4, u64_to_str(arg0.current_mint + 1));
        0x2::transfer::transfer<XYZNFT>(mint(v4, 0x1::string::utf8(b"MY TEST NFT FLORENTINO"), 0x2::url::new_unsafe_from_bytes(b"https://lienquan.garena.vn/files/skin/62cda115a78344fc4fa5154881c9da255c25f64ee32a7.jpg"), 0x1::string::utf8(b"level_one"), arg2), v1);
        arg0.current_mint = arg0.current_mint + 1;
        v3.is_mint = true;
    }

    public fun get_beneficiary(arg0: &MintingTreasury) : address {
        arg0.beneficiary
    }

    public fun get_level_info_probability<T0>(arg0: &LevelInfoValue<T0>) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(arg0.rarity_numerator, arg0.rarity_denumerator)
    }

    public fun get_level_mint_price<T0>(arg0: &LevelInfoValue<T0>) : u64 {
        arg0.mint_price
    }

    public fun get_level_price_info<T0>(arg0: &MintingTreasury, arg1: vector<u8>) : LevelInfoValue<T0> {
        let v0 = LevelInfoKey<T0>{level_name: arg1};
        assert!(0x2::dynamic_field::exists_with_type<LevelInfoKey<T0>, LevelInfoValue<T0>>(&arg0.id, v0), 2);
        let v1 = LevelInfoKey<T0>{level_name: arg1};
        *0x2::dynamic_field::borrow<LevelInfoKey<T0>, LevelInfoValue<T0>>(&arg0.id, v1)
    }

    public fun get_nft_id(arg0: &XYZNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_nft_next_level_name<T0>(arg0: &XYZNFT, arg1: &MintingTreasury) : vector<u8> {
        let v0 = get_level_price_info<T0>(arg1, *0x1::string::bytes(&arg0.level));
        v0.next_level_name
    }

    public fun get_nft_next_level_value<T0>(arg0: &XYZNFT, arg1: &MintingTreasury) : u64 {
        let v0 = get_level_price_info<T0>(arg1, *0x1::string::bytes(&arg0.level));
        v0.next_level_value
    }

    public fun image_url(arg0: &XYZNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://lienquan.garena.vn"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://lienquan.garena.vn"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{creator}"));
        let v6 = 0x2::display::new_with_fields<XYZNFT>(&v0, v2, v4, arg1);
        let v7 = MintingTreasury{
            id               : 0x2::object::new(arg1),
            current_mint     : 0,
            max_total        : 18446744073709551615,
            due_time         : 0,
            beneficiary      : v1,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            mint_ref_percent : 0x1::fixed_point32::create_from_rational(0, 1000),
            ref_pool_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::display::update_version<XYZNFT>(&mut v6);
        let v8 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MinterCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintingTreasury>(v7);
        0x2::transfer::public_transfer<0x2::display::Display<XYZNFT>>(v6, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::url::Url, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : XYZNFT {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = XYZNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            creator     : v0,
            level       : arg3,
        };
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        v1
    }

    public(friend) fun mint_to_account(arg0: &mut MintingTreasury, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.due_time, 1);
        let v0 = LevelInfoKey<0x2::sui::SUI>{level_name: b"level_one"};
        assert!(0x2::dynamic_field::exists_with_type<LevelInfoKey<0x2::sui::SUI>, LevelInfoValue<0x2::sui::SUI>>(&arg0.id, v0), 2);
        assert!(arg0.max_total > arg0.current_mint, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 != arg3, 11);
        let v2 = LevelInfoKey<0x2::sui::SUI>{level_name: b"level_one"};
        let v3 = *0x2::dynamic_field::borrow<LevelInfoKey<0x2::sui::SUI>, LevelInfoValue<0x2::sui::SUI>>(&arg0.id, v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3.mint_price, 0);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v1)) {
            let v4 = UserInfo{is_mint: false};
            0x2::dynamic_field::add<address, UserInfo>(&mut arg0.id, v1, v4);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v1);
        assert!(!v5.is_mint, 5);
        let v6 = 0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg2);
        let v7 = 0x1::fixed_point32::multiply_u64(v3.mint_price, arg0.mint_ref_percent);
        if (arg3 != @0x10 && 0x2::balance::value<0x2::sui::SUI>(&arg0.ref_pool_balance) >= v7) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.ref_pool_balance, v7, arg4), arg3);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(v6, v3.mint_price));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v6, 0x2::balance::value<0x2::sui::SUI>(v6) - v3.mint_price, arg4), v1);
        let v8 = 0x1::string::utf8(b"FLORENTINO NFT #");
        0x1::string::append(&mut v8, u64_to_str(arg0.current_mint + 1));
        0x2::transfer::transfer<XYZNFT>(mint(v8, 0x1::string::utf8(b"MY TEST NFT FLORENTINO"), 0x2::url::new_unsafe_from_bytes(b"https://lienquan.garena.vn/files/skin/62cda115a78344fc4fa5154881c9da255c25f64ee32a7.jpg"), 0x1::string::utf8(b"level_one"), arg4), v1);
        arg0.current_mint = arg0.current_mint + 1;
        v5.is_mint = true;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
    }

    public fun name(arg0: &XYZNFT) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun set_due_time(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg2), 6);
        arg1.due_time = arg3;
    }

    public(friend) fun set_max_total_mints(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: u64) {
        if (arg1.current_mint != 0) {
            assert!(arg2 > arg1.current_mint, 7);
        } else {
            assert!(arg2 > 1, 4);
        };
        arg1.max_total = arg2;
    }

    public(friend) fun set_mint_ref_percent(arg0: &MinterCap, arg1: &mut MintingTreasury, arg2: u64) {
        assert!(arg2 < 1000 && arg2 > 0, 10);
        arg1.mint_ref_percent = 0x1::fixed_point32::create_from_rational(arg2, 1000);
    }

    public(friend) fun transfer_minter_cap(arg0: MinterCap, arg1: &mut MintingTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<MinterCap>(arg0, v0);
        arg1.beneficiary = v0;
    }

    fun u64_to_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun update_description(arg0: &mut XYZNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_nft_to_next_level(arg0: XYZNFT, arg1: vector<u8>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2) {
            0x1::string::utf8(arg1)
        } else {
            arg0.level
        };
        let v1 = mint(arg0.name, arg0.description, arg0.image_url, v0, arg3);
        0x2::transfer::transfer<XYZNFT>(v1, 0x2::tx_context::sender(arg3));
        burn(arg0);
    }

    // decompiled from Move bytecode v6
}

