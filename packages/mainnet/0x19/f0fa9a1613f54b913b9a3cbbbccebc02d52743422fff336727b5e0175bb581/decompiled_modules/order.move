module 0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::order {
    struct ORDER has drop {
        dummy_field: bool,
    }

    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        user: address,
        recipient: address,
        balance: 0x2::balance::Balance<T0>,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
        encrypted_fields: vector<u8>,
    }

    struct OrderCap<phantom T0> {
        input_amount: u64,
        gas_amount: u64,
    }

    fun blake2b256(arg0: u64, arg1: u64, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x2::hash::blake2b256(&v0)
    }

    fun transfer<T0, T1>(arg0: Order<T0, T1>, arg1: &0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::config::Config, arg2: vector<u8>) {
        0x2::transfer::transfer<Order<T0, T1>>(arg0, 0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::config::derive_multisig_address(arg1, arg2));
    }

    fun assert_coin_has_non_zero_value<T0>(arg0: &0x2::coin::Coin<T0>) {
        assert!(0 < 0x2::coin::value<T0>(arg0), 1);
    }

    fun assert_coin_types_differ_for_self_transfer<T0, T1>(arg0: address, arg1: address) {
        if (arg0 == arg1) {
            assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0);
        };
    }

    fun assert_current_timestamp_is_less_than_expiry_timestamp(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg1, 3);
    }

    fun assert_input_params_match_encrypted_fields<T0, T1>(arg0: &Order<T0, T1>, arg1: u64, arg2: u64, arg3: vector<u8>) {
        assert!(arg0.encrypted_fields == blake2b256(arg1, arg2, arg3), 2);
    }

    fun assert_trade_resulted_in_valid_price(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 4);
    }

    public fun begin_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::Config, arg2: &mut 0x2::tx_context::TxContext) : (OrderCap<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.gas);
        let v2 = OrderCap<T1>{
            input_amount : v0,
            gas_amount   : v1,
        };
        (v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas, v1), arg2))
    }

    public fun close_order<T0, T1>(arg0: Order<T0, T1>, arg1: &0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::assert_interacting_with_most_up_to_date_package(arg1);
        let Order {
            id               : v0,
            user             : v1,
            recipient        : v2,
            balance          : v3,
            gas              : v4,
            encrypted_fields : v5,
        } = arg0;
        let v6 = v4;
        let v7 = v3;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2), v1);
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::events::emit_closed_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&arg0), v1, v2, 0x2::balance::value<T0>(&v7), 0x2::balance::value<0x2::sui::SUI>(&v6), v5);
    }

    public fun create_order<T0, T1>(arg0: &0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::config::Config, arg1: &0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::assert_interacting_with_most_up_to_date_package(arg1);
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::assert_enough_gas_was_provided(arg1, &arg3);
        assert_coin_has_non_zero_value<T0>(&arg2);
        assert_coin_types_differ_for_self_transfer<T0, T1>(0x2::tx_context::sender(arg7), arg5);
        0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::config::assert_public_key_corresponds_to_tx_sender(&arg4, v0);
        let v1 = Order<T0, T1>{
            id               : 0x2::object::new(arg7),
            user             : v0,
            recipient        : arg5,
            balance          : 0x2::coin::into_balance<T0>(arg2),
            gas              : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            encrypted_fields : arg6,
        };
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::events::emit_created_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&v1), v1.user, arg4, v1.recipient, 0x2::balance::value<T0>(&v1.balance), 0x2::balance::value<0x2::sui::SUI>(&v1.gas), v1.encrypted_fields);
        transfer<T0, T1>(v1, arg0, arg4);
    }

    public fun finish_tx<T0, T1>(arg0: Order<T0, T1>, arg1: &0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::Config, arg2: OrderCap<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: vector<u8>) {
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::assert_interacting_with_most_up_to_date_package(arg1);
        assert_input_params_match_encrypted_fields<T0, T1>(&arg0, arg5, arg6, arg7);
        assert_current_timestamp_is_less_than_expiry_timestamp(arg4, arg6);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert_trade_resulted_in_valid_price(arg5, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg0.recipient);
        let Order {
            id               : v1,
            user             : v2,
            recipient        : v3,
            balance          : v4,
            gas              : v5,
            encrypted_fields : _,
        } = arg0;
        0x2::object::delete(v1);
        0x2::balance::destroy_zero<T0>(v4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        let OrderCap {
            input_amount : v7,
            gas_amount   : v8,
        } = arg2;
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::events::emit_executed_trade_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&arg0), v2, v3, v7, v0, v8);
    }

    fun init(arg0: ORDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::config::create_config<ORDER>(&arg0, arg1);
        0x2::transfer::public_transfer<0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::admin::AdminCap>(0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::admin::create_admin_cap<ORDER>(&arg0, arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ORDER>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

