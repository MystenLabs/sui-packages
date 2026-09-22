module 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data {
    struct WaterXPrediction has drop {
        dummy_field: bool,
    }

    struct WaterXPredictionData has store {
        orders: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, u64>,
        positions: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, u64>,
        orders_by_market: 0x2::table::Table<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>,
        positions_by_market: 0x2::table::Table<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>,
    }

    public fun account_orders(arg0: &WaterXPredictionData) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, u64> {
        &arg0.orders
    }

    public fun account_positions(arg0: &WaterXPredictionData) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, u64> {
        &arg0.positions
    }

    public(friend) fun add_order(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_data(arg0, arg1, arg4);
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness());
        ensure_market_indexes(v0, arg2, arg4);
        let v1 = &mut v0.orders;
        let v2 = &mut v0.orders_by_market;
        push_index(v1, v2, arg2, arg3);
    }

    public(friend) fun add_order_for_existing_market(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness());
        assert_market_indexes(v0, arg2);
        let v1 = &mut v0.orders;
        let v2 = &mut v0.orders_by_market;
        push_index(v1, v2, arg2, arg3);
    }

    public(friend) fun add_position(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_data(arg0, arg1, arg4);
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness());
        ensure_market_indexes(v0, arg2, arg4);
        let v1 = &mut v0.positions;
        let v2 = &mut v0.positions_by_market;
        push_index(v1, v2, arg2, arg3);
    }

    fun assert_market_indexes(arg0: &WaterXPredictionData, arg1: u64) {
        assert!(0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1) && 0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1), 1);
    }

    public fun borrow_account(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : &WaterXPredictionData {
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data<WaterXPrediction, WaterXPredictionData>(arg0, arg1)
    }

    fun ensure_data(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPrediction>(arg0, arg1)) {
            return
        };
        let v0 = WaterXPredictionData{
            orders              : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, u64>(arg2),
            positions           : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, u64>(arg2),
            orders_by_market    : 0x2::table::new<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(arg2),
            positions_by_market : 0x2::table::new<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(arg2),
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::new_data<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness(), v0);
    }

    public(friend) fun ensure_market_for_account(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_data(arg0, arg1, arg3);
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness());
        ensure_market_indexes(v0, arg2, arg3);
    }

    fun ensure_market_indexes(arg0: &mut WaterXPredictionData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            0x2::table::add<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&mut arg0.orders_by_market, arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, bool>(arg2));
        };
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            0x2::table::add<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&mut arg0.positions_by_market, arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, bool>(arg2));
        };
    }

    public fun has_account(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : bool {
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPrediction>(arg0, arg1)
    }

    fun ids(arg0: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>) : vector<u64> {
        let v0 = vector[];
        let v1 = *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, bool>(arg0);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = *0x1::option::borrow<u64>(&v1);
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, bool>(arg0, v2);
        };
        v0
    }

    public fun market_order_back(arg0: &WaterXPredictionData, arg1: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            return 0x1::option::none<u64>()
        };
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1))
    }

    public fun market_order_count(arg0: &WaterXPredictionData, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1))
    }

    public fun market_order_front(arg0: &WaterXPredictionData, arg1: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            return 0x1::option::none<u64>()
        };
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1))
    }

    public fun market_order_next(arg0: &WaterXPredictionData, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            return 0x1::option::none<u64>()
        };
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1), arg2)
    }

    public fun market_position_back(arg0: &WaterXPredictionData, arg1: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            return 0x1::option::none<u64>()
        };
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1))
    }

    public fun market_position_count(arg0: &WaterXPredictionData, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1))
    }

    public fun market_position_front(arg0: &WaterXPredictionData, arg1: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            return 0x1::option::none<u64>()
        };
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1))
    }

    public fun market_position_next(arg0: &WaterXPredictionData, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            return 0x1::option::none<u64>()
        };
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1), arg2)
    }

    public fun order_back(arg0: &WaterXPredictionData) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, u64>(&arg0.orders)
    }

    public fun order_count(arg0: &WaterXPredictionData) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, u64>(&arg0.orders)
    }

    public fun order_front(arg0: &WaterXPredictionData) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, u64>(&arg0.orders)
    }

    public fun order_ids_by_market(arg0: &WaterXPredictionData, arg1: u64) : vector<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            return vector[]
        };
        ids(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1))
    }

    public fun order_market_key(arg0: &WaterXPredictionData, arg1: u64) : u64 {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, u64>(&arg0.orders, arg1)
    }

    public fun order_next(arg0: &WaterXPredictionData, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, u64>(&arg0.orders, arg1)
    }

    public fun perm_cancel_order() : u32 {
        2
    }

    public fun perm_claim() : u32 {
        4
    }

    public fun perm_place_order() : u32 {
        1
    }

    public fun perm_request_close() : u32 {
        8
    }

    public fun perm_transfer_position() : u32 {
        16
    }

    public fun position_back(arg0: &WaterXPredictionData) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, u64>(&arg0.positions)
    }

    public fun position_count(arg0: &WaterXPredictionData) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, u64>(&arg0.positions)
    }

    public fun position_front(arg0: &WaterXPredictionData) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, u64>(&arg0.positions)
    }

    public fun position_ids_by_market(arg0: &WaterXPredictionData, arg1: u64) : vector<u64> {
        if (!0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            return vector[]
        };
        ids(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1))
    }

    public fun position_market_key(arg0: &WaterXPredictionData, arg1: u64) : u64 {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, u64>(&arg0.positions, arg1)
    }

    public fun position_next(arg0: &WaterXPredictionData, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, u64>(&arg0.positions, arg1)
    }

    fun prune_market_indexes(arg0: &mut WaterXPredictionData, arg1: u64) {
        let v0 = !0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1));
        let v1 = !0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, bool>(0x2::table::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1));
        let v2 = v0 && v1;
        if (!v2) {
            return
        };
        if (0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.orders_by_market, arg1)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::destroy_empty<u64, bool>(0x2::table::remove<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&mut arg0.orders_by_market, arg1));
        };
        if (0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&arg0.positions_by_market, arg1)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::destroy_empty<u64, bool>(0x2::table::remove<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(&mut arg0.positions_by_market, arg1));
        };
    }

    fun push_index(arg0: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, u64>, arg1: &mut 0x2::table::Table<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>, arg2: u64, arg3: u64) {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, u64>(arg0, arg3, arg2);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, bool>(0x2::table::borrow_mut<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(arg1, arg2), arg3, true);
    }

    fun remove_index(arg0: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, u64>, arg1: &mut 0x2::table::Table<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>, arg2: u64, arg3: u64) {
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, u64>(arg0, arg3)) {
            return
        };
        assert!(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, u64>(arg0, arg3) == arg2, 1);
        if (0x2::table::contains<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(arg1, arg2)) {
            let v0 = 0x2::table::borrow_mut<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, bool>>(arg1, arg2);
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, bool>(v0, arg3)) {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, bool>(v0, arg3);
            };
        };
    }

    public(friend) fun remove_order(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPrediction>(arg0, arg1)) {
            return
        };
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness());
        let v1 = &mut v0.orders;
        let v2 = &mut v0.orders_by_market;
        remove_index(v1, v2, arg2, arg3);
        prune_market_indexes(v0, arg2);
    }

    public(friend) fun remove_position(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPrediction>(arg0, arg1)) {
            return
        };
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPrediction, WaterXPredictionData>(arg0, arg1, witness());
        let v1 = &mut v0.positions;
        let v2 = &mut v0.positions_by_market;
        remove_index(v1, v2, arg2, arg3);
        prune_market_indexes(v0, arg2);
    }

    public(friend) fun witness() : WaterXPrediction {
        WaterXPrediction{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

