module 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::swap {
    struct SwapGlobal has key {
        id: 0x2::object::UID,
        creator: address,
        phase: u64,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_SHUI: 0x2::balance::Balance<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>,
        swaped_shui: u64,
        swaped_sui: u64,
        whitelist_table: 0x2::table::Table<address, u64>,
        ticket_map: 0x2::table::Table<u64, bool>,
    }

    public fun get_is_whitelist(arg0: &SwapGlobal, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.whitelist_table, 0x2::tx_context::sender(arg1))) {
            1
        } else {
            0
        }
    }

    public fun get_swaped_shui(arg0: &SwapGlobal) : u64 {
        arg0.swaped_shui
    }

    public fun get_swaped_sui(arg0: &SwapGlobal) : u64 {
        arg0.swaped_sui
    }

    public entry fun get_total_shui_balance(arg0: &SwapGlobal) : u64 {
        0x2::balance::value<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(&arg0.balance_SHUI)
    }

    public entry fun get_total_sui_balance(arg0: &SwapGlobal) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_SUI)
    }

    fun has_swap_amount(arg0: &0x2::table::Table<address, u64>, arg1: u64, arg2: address) : bool {
        *0x2::table::borrow<address, u64>(arg0, arg2) >= arg1
    }

    public entry fun ieo_swap(arg0: &mut SwapGlobal, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 5
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapGlobal{
            id              : 0x2::object::new(arg0),
            creator         : 0x2::tx_context::sender(arg0),
            phase           : 0,
            balance_SUI     : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_SHUI    : 0x2::balance::zero<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(),
            swaped_shui     : 0,
            swaped_sui      : 0,
            whitelist_table : 0x2::table::new<address, u64>(arg0),
            ticket_map      : 0x2::table::new<u64, bool>(arg0),
        };
        0x2::transfer::share_object<SwapGlobal>(v0);
    }

    public fun init_funds_from_main_contract(arg0: &mut SwapGlobal, arg1: &mut 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(&mut arg0.balance_SHUI, 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::extract_swap_balance(arg1, arg2));
    }

    public fun is_in_whitelist(arg0: &SwapGlobal, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::table::contains<address, u64>(&arg0.whitelist_table, 0x2::tx_context::sender(arg1))
    }

    public entry fun public_swap(arg0: &mut SwapGlobal, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 1, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1 * 150;
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>>(0x2::coin::from_balance<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(0x2::balance::split<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(&mut arg0.balance_SHUI, v1 * 1000000000), arg3), v0);
    }

    fun record_swaped_amount(arg0: &mut 0x2::table::Table<address, u64>, arg1: u64, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg2);
        *v0 = *v0 - arg1;
    }

    public fun set_phase(arg0: &mut SwapGlobal, arg1: u64) {
        assert!(arg1 == arg0.phase + 1, 6);
        arg0.phase = arg1;
    }

    public fun set_whitelist(arg0: &mut SwapGlobal, arg1: &mut 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::boat_ticket::BoatTicket, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, u64>(&mut arg0.whitelist_table, 0x2::tx_context::sender(arg2), 60000);
        assert!(!0x2::table::contains<u64, bool>(&arg0.ticket_map, 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::boat_ticket::get_index(arg1)), 8);
        0x2::table::add<u64, bool>(&mut arg0.ticket_map, 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::boat_ticket::get_index(arg1), true);
        assert!(0x2::table::length<address, u64>(&arg0.whitelist_table) <= 5000, 1);
    }

    public entry fun white_list_swap(arg0: &mut SwapGlobal, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 800;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg1 * v0;
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist_table, 0x2::tx_context::sender(arg3)), 3);
        assert!(has_swap_amount(&arg0.whitelist_table, v2, v1), 2);
        arg0.swaped_shui = arg0.swaped_shui + v2 * 1000000000;
        arg0.swaped_sui = arg0.swaped_sui + arg1 * 1000000000;
        let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v3, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v3) >= 1, 4);
        assert!(arg1 <= 60000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, arg1 * 1000000000, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>>(0x2::coin::from_balance<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(0x2::balance::split<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(&mut arg0.balance_SHUI, v2 * 1000000000), arg3), v1);
        let v4 = &mut arg0.whitelist_table;
        record_swaped_amount(v4, arg1 * v0, v1);
    }

    public entry fun withdraw_shui(arg0: &mut SwapGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>>(0x2::coin::from_balance<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(0x2::balance::split<0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::shui::SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui(arg0: &mut SwapGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

