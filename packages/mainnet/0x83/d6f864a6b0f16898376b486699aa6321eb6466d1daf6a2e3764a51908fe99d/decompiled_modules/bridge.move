module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::bridge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollectorCap has store {
        dummy_field: bool,
    }

    struct StopSwapCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        pools: 0x2::object_bag::ObjectBag,
        other_bridges: 0x2::table::Table<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>,
        processed_messages: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>,
        sent_messages: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>,
        fee_collector: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::FeeCollector<FeeCollectorCap>,
        fee_collector_cap: FeeCollectorCap,
        rebalancer: address,
        can_swap: bool,
    }

    public(friend) fun swap<T0, T1>(arg0: &mut Bridge, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.can_swap, 6);
        let v0 = arg0.rebalancer;
        let v1 = pool_mut<T0>(arg0);
        let v2 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::swap_from_vusd<T1>(pool_mut<T1>(arg0), 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::swap_to_vusd<T0>(v1, arg1, 0x2::tx_context::sender(arg3) == v0, arg3), arg2, 0x2::tx_context::sender(arg3) == v0, arg3);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::swapped_event<T0, T1>(0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&v2), 0x2::tx_context::sender(arg3));
        v2
    }

    public(friend) fun gas_usage(arg0: &Bridge, arg1: u8) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::gas_usage(0x2::table::borrow<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg1))
    }

    public(friend) fun set_gas_usage(arg0: &mut Bridge, arg1: u8, arg2: u64) {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::set_gas_usage(0x2::table::borrow_mut<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&mut arg0.other_bridges, arg1), arg2);
    }

    public(friend) fun add_bridge(arg0: &mut Bridge, arg1: u8, arg2: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&mut arg0.other_bridges, arg1, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::new(arg2, arg3));
    }

    public(friend) fun add_bridge_token(arg0: &mut Bridge, arg1: u8, arg2: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::add_token(0x2::table::borrow_mut<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&mut arg0.other_bridges, arg1), arg2);
    }

    public(friend) fun add_pool<T0>(arg0: &mut Bridge, arg1: 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0>) {
        0x2::object_bag::add<0x1::type_name::TypeName, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0>>(&mut arg0.pools, get_pool_key<T0>(), arg1);
    }

    public(friend) fun pool<T0>(arg0: &Bridge) : &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0> {
        0x2::object_bag::borrow<0x1::type_name::TypeName, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0>>(&arg0.pools, get_pool_key<T0>())
    }

    public(friend) fun admin_fee_share_bp<T0>(arg0: &mut Bridge) : u64 {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::get_admin_fee_share_bp<T0>(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::rewards<T0>(pool_mut<T0>(arg0)))
    }

    public(friend) fun can_swap(arg0: &Bridge) : bool {
        arg0.can_swap
    }

    public(friend) fun deposit_fee<T0>(arg0: &mut Bridge, arg1: 0x2::coin::Coin<T0>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<T0, FeeCollectorCap>(&mut arg0.fee_collector, arg1);
    }

    public(friend) fun fee_value<T0>(arg0: &mut Bridge) : u64 {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::balance<T0, FeeCollectorCap>(&mut arg0.fee_collector)
    }

    public(friend) fun get_bridge_allbridge_cost(arg0: &Bridge, arg1: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: u8) : u64 {
        get_bridge_cost(arg0, arg2, arg3) + 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger_interface::get_transaction_cost(arg1, arg2, arg3)
    }

    public(friend) fun get_bridge_cost(arg0: &Bridge, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::get_transaction_gas_cost_in_native_token(arg1, arg2, gas_usage(arg0, arg2))
    }

    public(friend) fun get_bridge_wormhole_cost(arg0: &Bridge, arg1: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg4: u8) : u64 {
        get_bridge_cost(arg0, arg3, arg4) + 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wh_messenger_interface::get_transaction_cost(arg1, arg2, arg3, arg4)
    }

    public(friend) fun get_id(arg0: &Bridge) : &0x2::object::UID {
        &arg0.id
    }

    fun get_pool_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public(friend) fun get_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::init_version<AdminCap>(&v0, &mut v1, 1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v2 = StopSwapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StopSwapCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = FeeCollectorCap{dummy_field: false};
        let v4 = Bridge{
            id                 : v1,
            pools              : 0x2::object_bag::new(arg0),
            other_bridges      : 0x2::table::new<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(arg0),
            processed_messages : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(arg0),
            sent_messages      : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(arg0),
            fee_collector      : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::new<FeeCollectorCap>(arg0),
            fee_collector_cap  : v3,
            rebalancer         : @0x0,
            can_swap           : true,
        };
        0x2::transfer::share_object<Bridge>(v4);
    }

    public(friend) fun is_processed_message(arg0: &Bridge, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) : bool {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.processed_messages, arg1)
    }

    public(friend) fun migrate(arg0: &AdminCap, arg1: &mut Bridge) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::migrate_version<AdminCap>(arg0, &mut arg1.id, 1);
    }

    public(friend) fun pool_mut<T0>(arg0: &mut Bridge) : &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0> {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::Pool<T0>>(&mut arg0.pools, get_pool_key<T0>())
    }

    public(friend) fun receive_tokens_allbridge<T0>(arg0: &mut Bridge, arg1: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: u64, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: u8, arg5: u256, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::allbridge();
        assert!(arg0.can_swap, 6);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::bridge_address(0x2::table::borrow<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg4));
        let v3 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_id(&v2);
        let v4 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::from_args_with_sender(arg2, arg3, arg4, 13, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::from_ascii_hex(0x1::type_name::get_address(&v1)), arg5, v0, &v3);
        assert!(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger_interface::has_received_message(arg1, v4), 1);
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.processed_messages, v4), 2);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.processed_messages, v4);
        let v5 = arg0.rebalancer;
        let v6 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_address(&arg3);
        let v7 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::swap_from_vusd<T0>(pool_mut<T0>(arg0), arg2, arg6, v6 == v5, arg8);
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v6);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::tokens_received_event<T0>(0x2::coin::value<T0>(&v7), v8, v6, arg5, v0, v4);
    }

    public(friend) fun receive_tokens_wormhole<T0>(arg0: &mut Bridge, arg1: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: u64, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg4: u8, arg5: u256, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::wormhole();
        assert!(arg0.can_swap, 6);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::bridge_address(0x2::table::borrow<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg4));
        let v3 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_id(&v2);
        let v4 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::from_args_with_sender(arg2, arg3, arg4, 13, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::from_ascii_hex(0x1::type_name::get_address(&v1)), arg5, v0, &v3);
        assert!(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wh_messenger_interface::has_received_message(arg1, v4), 1);
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.processed_messages, v4), 2);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.processed_messages, v4);
        let v5 = arg0.rebalancer;
        let v6 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::to_address(&arg3);
        let v7 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::swap_from_vusd<T0>(pool_mut<T0>(arg0), arg2, arg6, v6 == v5, arg8);
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v6);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::tokens_received_event<T0>(0x2::coin::value<T0>(&v7), v8, v6, arg5, v0, v4);
    }

    public(friend) fun remove_bridge(arg0: &mut Bridge, arg1: u8) {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::destroy_empty(0x2::table::remove<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&mut arg0.other_bridges, arg1));
    }

    public(friend) fun remove_bridge_token(arg0: &mut Bridge, arg1: u8, arg2: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::remove_token(0x2::table::borrow_mut<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&mut arg0.other_bridges, arg1), arg2);
    }

    public(friend) fun set_rebalancer(arg0: &mut Bridge, arg1: address) {
        arg0.rebalancer = arg1;
    }

    public(friend) fun start_swap(arg0: &mut Bridge) {
        arg0.can_swap = true;
    }

    public(friend) fun stop_swap(arg0: &mut Bridge) {
        arg0.can_swap = false;
    }

    public(friend) fun swap_and_bridge_allbridge<T0>(arg0: &mut Bridge, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: 0x2::coin::Coin<T0>, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg5: u8, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg7: u256, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::allbridge();
        assert!(arg0.can_swap, 6);
        assert!(0x2::table::contains<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg5), 4);
        assert!(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::has_token(0x2::table::borrow<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg5), arg6), 5);
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::is_zero(&arg4), 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        let v2 = 0x2::coin::value<T0>(&arg9);
        let v3 = arg0.rebalancer;
        let v4 = pool_mut<T0>(arg0);
        let v5 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::swap_to_vusd<T0>(v4, arg3, 0x2::tx_context::sender(arg10) == v3, arg10);
        let v6 = get_bridge_cost(arg0, arg2, arg5);
        let v7 = 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger_interface::get_transaction_cost(arg1, arg2, arg5);
        let v8 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::from_args(v5, arg4, 13, arg5, arg6, arg7, v0);
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.sent_messages, v8), 3);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.sent_messages, v8);
        let v9 = 0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::stable_to_sui_amount(arg2, v2, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::decimals<T0>(pool<T0>(arg0))) + v1;
        assert!(v9 >= v6 + v7, 0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<0x2::sui::SUI, FeeCollectorCap>(&mut arg0.fee_collector, arg8);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<T0, FeeCollectorCap>(&mut arg0.fee_collector, arg9);
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger_interface::send_message(arg1, arg2, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::withdraw<0x2::sui::SUI, FeeCollectorCap>(&arg0.fee_collector_cap, &mut arg0.fee_collector, v7, arg10), v8, &arg0.id);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::receive_fee_event(v1, v2, v9, v6, v7, v6 + v7);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::tokens_sent_event<T0>(v5, 0x2::tx_context::sender(arg10), arg4, arg5, arg6, arg7, v0);
    }

    public(friend) fun swap_and_bridge_wormhole<T0>(arg0: &mut Bridge, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0x2::clock::Clock, arg4: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg5: 0x2::coin::Coin<T0>, arg6: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg7: u8, arg8: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32, arg9: u256, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol::wormhole();
        assert!(arg0.can_swap, 6);
        assert!(0x2::table::contains<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg7), 4);
        assert!(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::has_token(0x2::table::borrow<u8, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::another_bridge::AnotherBridge>(&arg0.other_bridges, arg7), arg8), 5);
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::is_zero(&arg6), 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg10);
        let v2 = 0x2::coin::value<T0>(&arg11);
        let v3 = arg0.rebalancer;
        let v4 = pool_mut<T0>(arg0);
        let v5 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::swap_to_vusd<T0>(v4, arg5, 0x2::tx_context::sender(arg12) == v3, arg12);
        let v6 = get_bridge_cost(arg0, arg4, arg7);
        let v7 = 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wh_messenger_interface::get_transaction_cost(arg1, arg2, arg4, arg7);
        let v8 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::from_args(v5, arg6, 13, arg7, arg8, arg9, v0);
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.sent_messages, v8), 3);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.sent_messages, v8);
        let v9 = 0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::stable_to_sui_amount(arg4, v2, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool::decimals<T0>(pool<T0>(arg0))) + v1;
        assert!(v9 >= v6 + v7, 0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<0x2::sui::SUI, FeeCollectorCap>(&mut arg0.fee_collector, arg10);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::add_fee<T0, FeeCollectorCap>(&mut arg0.fee_collector, arg11);
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wh_messenger_interface::send_message(arg1, arg2, arg4, v8, &arg0.id, arg3, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::withdraw<0x2::sui::SUI, FeeCollectorCap>(&arg0.fee_collector_cap, &mut arg0.fee_collector, v7, arg12), arg12);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::receive_fee_event(v1, v2, v9, v6, v7, v6 + v7);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::tokens_sent_event<T0>(v5, 0x2::tx_context::sender(arg12), arg6, arg7, arg8, arg9, v0);
    }

    public(friend) fun withdraw_fee<T0>(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector::withdraw<T0, FeeCollectorCap>(&arg0.fee_collector_cap, &mut arg0.fee_collector, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

