module 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::tree_of_life_record {
    struct GlobalRecords has key {
        id: 0x2::object::UID,
        creator: address,
        shui_token_pre_white_list: 0x2::table::Table<address, vector<address>>,
        meta_game_pre_white_list: 0x2::table::Table<address, vector<address>>,
        valid_shui_token_whitelist: vector<address>,
        valid_meta_game_whitelist: vector<address>,
    }

    public entry fun get_meta_game_pre_white_list(arg0: &mut GlobalRecords, arg1: address) : vector<address> {
        *0x2::table::borrow<address, vector<address>>(&arg0.meta_game_pre_white_list, arg1)
    }

    public entry fun get_meta_game_white_list(arg0: &GlobalRecords) : vector<address> {
        arg0.valid_meta_game_whitelist
    }

    public entry fun get_shui_token_pre_white_list(arg0: &mut GlobalRecords, arg1: address) : vector<address> {
        *0x2::table::borrow<address, vector<address>>(&arg0.shui_token_pre_white_list, arg1)
    }

    public entry fun get_shui_token_white_list(arg0: &GlobalRecords) : vector<address> {
        arg0.valid_shui_token_whitelist
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalRecords{
            id                         : 0x2::object::new(arg0),
            creator                    : 0x2::tx_context::sender(arg0),
            shui_token_pre_white_list  : 0x2::table::new<address, vector<address>>(arg0),
            meta_game_pre_white_list   : 0x2::table::new<address, vector<address>>(arg0),
            valid_shui_token_whitelist : 0x1::vector::empty<address>(),
            valid_meta_game_whitelist  : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<GlobalRecords>(v0);
    }

    public fun record_meta_game_nft(arg0: &mut GlobalRecords, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.meta_game_pre_white_list, arg1)) {
            let v0 = vector[];
            0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg2));
            0x2::table::add<address, vector<address>>(&mut arg0.meta_game_pre_white_list, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.meta_game_pre_white_list, arg1);
            let v2 = 0x2::tx_context::sender(arg2);
            assert!(!0x1::vector::contains<address>(v1, &v2), 1);
            0x1::vector::push_back<address>(v1, 0x2::tx_context::sender(arg2));
        };
    }

    public fun record_shui_token(arg0: &mut GlobalRecords, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.shui_token_pre_white_list, arg1)) {
            let v0 = vector[];
            0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg2));
            0x2::table::add<address, vector<address>>(&mut arg0.shui_token_pre_white_list, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.shui_token_pre_white_list, arg1);
            let v2 = 0x2::tx_context::sender(arg2);
            assert!(!0x1::vector::contains<address>(v1, &v2), 1);
            0x1::vector::push_back<address>(v1, 0x2::tx_context::sender(arg2));
        };
    }

    public fun set_valid_meta_game_white_list(arg0: &mut GlobalRecords, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<address>(&mut arg0.valid_meta_game_whitelist, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
    }

    public fun set_valid_shui_token_white_list(arg0: &mut GlobalRecords, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<address>(&mut arg0.valid_shui_token_whitelist, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

