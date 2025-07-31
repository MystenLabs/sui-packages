module 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options {
    struct OptionsStorage has store, key {
        id: 0x2::object::UID,
        admin: address,
        escrow_address: address,
        escrow_fee: u64,
        collection_size: u64,
        stage_name: 0x1::string::String,
        mint_price: u64,
        mint_price_zen: u64,
        stage_quantity_per_wallet: u64,
        limit_per_wallet_enabled: bool,
        mint_enabled: bool,
        voting_enabled: bool,
        only_airdrop_mint: bool,
        airdrop: 0x2::table::Table<address, bool>,
    }

    public fun admin_bulk_add_to_airdrop(arg0: &mut OptionsStorage, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.airdrop, v1)) {
                0x2::table::add<address, bool>(&mut arg0.airdrop, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun admin_bulk_remove_from_airdrop(arg0: &mut OptionsStorage, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.airdrop, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.airdrop, v1);
            };
            v0 = v0 + 1;
        };
    }

    entry fun admin_update_options(arg0: &mut OptionsStorage, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: &0x2::tx_context::TxContext) {
        assert_is_admin(arg0, arg12);
        arg0.escrow_address = arg1;
        arg0.escrow_fee = arg2;
        arg0.collection_size = arg3;
        arg0.mint_price = arg4;
        arg0.mint_price_zen = arg5;
        arg0.stage_name = 0x1::string::utf8(arg6);
        arg0.stage_quantity_per_wallet = arg7;
        arg0.limit_per_wallet_enabled = arg8;
        arg0.mint_enabled = arg9;
        arg0.voting_enabled = arg10;
        arg0.only_airdrop_mint = arg11;
    }

    public(friend) fun assert_is_admin(arg0: &OptionsStorage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public(friend) fun assert_is_airdrop_eligible(arg0: address, arg1: &OptionsStorage) {
        assert!(0x2::table::contains<address, bool>(&arg1.airdrop, arg0) == true, 1);
    }

    public(friend) fun assert_is_mint_enabled(arg0: &OptionsStorage) {
        assert!(arg0.mint_enabled == true, 1);
    }

    public(friend) fun assert_is_voting_enabled(arg0: &OptionsStorage) {
        assert!(arg0.voting_enabled == true, 2);
    }

    public(friend) fun assert_is_zen_coin<T0>() {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::ascii::string(b"2665dc784c7ff17fddba2442b36cb8b2bbc8adfa9fe08794fd941d80ef2758ec::zen::ZEN"), 3);
    }

    public(friend) fun create_options_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OptionsStorage{
            id                        : 0x2::object::new(arg0),
            admin                     : 0x2::tx_context::sender(arg0),
            escrow_address            : @0xcd669fd129884c6ad69526a3d3b59749b04b34ac8686539928c9e85eca167f53,
            escrow_fee                : 25,
            collection_size           : 3333,
            stage_name                : 0x1::string::utf8(b"Initial Stage"),
            mint_price                : 5,
            mint_price_zen            : 5,
            stage_quantity_per_wallet : 1,
            limit_per_wallet_enabled  : false,
            mint_enabled              : false,
            voting_enabled            : false,
            only_airdrop_mint         : true,
            airdrop                   : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<OptionsStorage>(v0);
    }

    public fun get_admin(arg0: &OptionsStorage) : address {
        arg0.admin
    }

    public(friend) fun get_mint_options(arg0: &OptionsStorage) : (address, u64, u64, u64, bool, bool, bool) {
        (arg0.escrow_address, arg0.mint_price, arg0.mint_price_zen, arg0.stage_quantity_per_wallet, arg0.limit_per_wallet_enabled, arg0.mint_enabled, arg0.only_airdrop_mint)
    }

    public fun get_options(arg0: &OptionsStorage) : (address, u64, u64, u64, u64, 0x1::string::String, u64, bool, bool, bool, bool) {
        (arg0.escrow_address, arg0.escrow_fee, arg0.collection_size, arg0.mint_price, arg0.mint_price_zen, arg0.stage_name, arg0.stage_quantity_per_wallet, arg0.limit_per_wallet_enabled, arg0.mint_enabled, arg0.voting_enabled, arg0.only_airdrop_mint)
    }

    // decompiled from Move bytecode v6
}

