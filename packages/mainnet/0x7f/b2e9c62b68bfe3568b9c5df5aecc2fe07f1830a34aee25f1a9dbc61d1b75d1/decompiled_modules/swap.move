module 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::swap {
    struct SwapGlobal has key {
        id: 0x2::object::UID,
        creator: address,
        crypto: address,
        phase: u64,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_SHUI: 0x2::balance::Balance<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>,
        swaped_shui: u64,
        swaped_sui: u64,
        whitelist_table: 0x2::table::Table<address, u64>,
        version: u64,
    }

    public fun change_owner(arg0: &mut SwapGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.creator = arg1;
    }

    public fun get_swaped_shui(arg0: &SwapGlobal) : u64 {
        arg0.swaped_shui
    }

    public fun get_swaped_sui(arg0: &SwapGlobal) : u64 {
        arg0.swaped_sui
    }

    public entry fun get_total_shui_balance(arg0: &SwapGlobal) : u64 {
        0x2::balance::value<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(&arg0.balance_SHUI)
    }

    public entry fun get_total_sui_balance(arg0: &SwapGlobal) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    public entry fun gold_reserve_swap(arg0: &mut SwapGlobal, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1 * 1;
        arg0.swaped_shui = arg0.swaped_shui + v1 * 1000000000;
        arg0.swaped_sui = arg0.swaped_sui + arg1 * 1000000000;
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v2, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= 1, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, arg1 * 1000000000, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>>(0x2::coin::from_balance<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(0x2::balance::split<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(&mut arg0.balance_SHUI, v1 * 1000000000), arg3), v0);
    }

    fun has_swap_amount(arg0: &0x2::table::Table<address, u64>, arg1: u64, arg2: address) : bool {
        *0x2::table::borrow<address, u64>(arg0, arg2) >= arg1
    }

    public fun increment(arg0: &mut SwapGlobal, arg1: u64) {
        assert!(arg0.version == 0, 8);
        arg0.version = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapGlobal{
            id              : 0x2::object::new(arg0),
            creator         : 0x2::tx_context::sender(arg0),
            crypto          : @0xfbbea5cd4a5039652c5e565b22551fc9253f5df9b415ca269689c1c32f4a1cfc,
            phase           : 0,
            balance_SUI     : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_SHUI    : 0x2::balance::zero<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(),
            swaped_shui     : 0,
            swaped_sui      : 0,
            whitelist_table : 0x2::table::new<address, u64>(arg0),
            version         : 0,
        };
        0x2::transfer::share_object<SwapGlobal>(v0);
    }

    public fun init_funds_from_main_contract(arg0: &mut SwapGlobal, arg1: &mut 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(&mut arg0.balance_SHUI, 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::extract_swap_balance(arg1, arg2));
    }

    public entry fun public_swap(arg0: &mut SwapGlobal, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        assert!(arg0.phase == 1, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1 * 10;
        arg0.swaped_shui = arg0.swaped_shui + v1 * 1000000000;
        arg0.swaped_sui = arg0.swaped_sui + arg1 * 1000000000;
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v2, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= 1000000000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, arg1 * 1000000000, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>>(0x2::coin::from_balance<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(0x2::balance::split<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(&mut arg0.balance_SHUI, v1 * 1000000000), arg3), v0);
    }

    fun record_swaped_amount(arg0: &mut 0x2::table::Table<address, u64>, arg1: u64, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg2);
        *v0 = *v0 - arg1;
    }

    public fun set_phase(arg0: &mut SwapGlobal, arg1: u64) {
        assert!(arg1 == arg0.phase + 1, 6);
        arg0.phase = arg1;
    }

    public(friend) fun set_whitelist(arg0: &mut SwapGlobal, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, u64>(&arg0.whitelist_table, v0)) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_table, v0, 100);
        };
        assert!(0x2::table::length<address, u64>(&arg0.whitelist_table) <= 10000, 1);
    }

    public fun white_list_backup(arg0: &mut SwapGlobal, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(arg0.crypto);
        let v1 = 0x2::tx_context::sender(arg3);
        0x1::debug::print<vector<u8>>(arg1);
        0x1::debug::print<vector<u8>>(arg2);
        0x1::debug::print<vector<u8>>(&v0);
        assert!(*arg2 == 0x2::address::to_bytes(v1), 7);
        assert!(0x2::ed25519::ed25519_verify(arg1, &v0, arg2), 1);
        0x2::table::add<address, u64>(&mut arg0.whitelist_table, v1, 100);
        assert!(0x2::table::length<address, u64>(&arg0.whitelist_table) <= 10000, 1);
    }

    public entry fun white_list_swap(arg0: &mut SwapGlobal, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        let v0 = 100;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg1 * v0;
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist_table, 0x2::tx_context::sender(arg3)), 3);
        assert!(has_swap_amount(&arg0.whitelist_table, v2, v1), 2);
        arg0.swaped_shui = arg0.swaped_shui + v2 * 1000000000;
        arg0.swaped_sui = arg0.swaped_sui + arg1 * 1000000000;
        let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v3, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v3) >= 1, 4);
        assert!(arg1 <= 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, arg1 * 1000000000, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>>(0x2::coin::from_balance<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(0x2::balance::split<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(&mut arg0.balance_SHUI, v2 * 1000000000), arg3), v1);
        let v4 = &mut arg0.whitelist_table;
        record_swaped_amount(v4, arg1 * v0, v1);
    }

    public entry fun withdraw_shui(arg0: &mut SwapGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>>(0x2::coin::from_balance<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(0x2::balance::split<0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::shui::SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui(arg0: &mut SwapGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

