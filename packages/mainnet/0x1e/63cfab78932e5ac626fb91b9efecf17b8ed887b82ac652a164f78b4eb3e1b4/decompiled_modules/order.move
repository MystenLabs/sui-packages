module 0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::order {
    struct ORDER has drop {
        dummy_field: bool,
    }

    struct IntegratorFeeConfig has copy, drop, store {
        fee_bps: u16,
        fee_recipient: address,
    }

    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        user: address,
        recipient: address,
        input_amount: u64,
        remaining_balance: 0x2::balance::Balance<T0>,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
        encrypted_fields: vector<u8>,
        integrator_fee_config: IntegratorFeeConfig,
    }

    struct OrderCap<phantom T0> {
        trade_amount: u64,
        gas_amount: u64,
    }

    fun blake2b256(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x2::hash::blake2b256(&v0)
    }

    fun transfer<T0, T1>(arg0: Order<T0, T1>, arg1: &0xbc33614900f37a4560cee4330963558bf7731b236a37a6a3c4c3064f9e89c4d::config::Config, arg2: vector<u8>) {
        0x2::transfer::transfer<Order<T0, T1>>(arg0, 0xbc33614900f37a4560cee4330963558bf7731b236a37a6a3c4c3064f9e89c4d::config::derive_multisig_address(arg1, arg2));
    }

    fun assert_coin_has_non_zero_value<T0>(arg0: &0x2::coin::Coin<T0>) {
        assert!(0 < 0x2::coin::value<T0>(arg0), 9223374648195022851);
    }

    fun assert_coin_types_differ_for_self_transfer<T0, T1>(arg0: address, arg1: address) {
        if (arg0 == arg1) {
            assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 9223374669669728257);
        };
    }

    fun assert_current_timestamp_is_less_than_expiry_timestamp(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg1, 9223374785634238471);
    }

    fun assert_input_params_match_encrypted_fields<T0, T1>(arg0: &Order<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>) {
        assert!(arg0.encrypted_fields == blake2b256(arg1, arg2, arg3, arg4), 9223374746979401733);
    }

    public fun begin_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (OrderCap<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.remaining_balance, arg2), arg3);
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::take_protocol_fee<T0>(arg1, &mut v0, arg3);
        let v1 = &mut v0;
        take_integrator_fee<T0, T1>(arg0, v1, arg3);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.gas);
        let v3 = OrderCap<T1>{
            trade_amount : arg2,
            gas_amount   : v2,
        };
        (v3, v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas, v2), arg3))
    }

    public fun close_order<T0, T1>(arg0: Order<T0, T1>, arg1: &0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::assert_interacting_with_most_up_to_date_package(arg1);
        let Order {
            id                    : v0,
            user                  : v1,
            recipient             : v2,
            input_amount          : v3,
            remaining_balance     : v4,
            gas                   : v5,
            encrypted_fields      : v6,
            integrator_fee_config : _,
        } = arg0;
        let v8 = v5;
        let v9 = v4;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg2), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg2), v1);
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::events::emit_closed_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&arg0), v1, v3, v2, 0x2::balance::value<T0>(&v9), 0x2::balance::value<0x2::sui::SUI>(&v8), v6);
    }

    public fun create_order<T0, T1>(arg0: &0xbc33614900f37a4560cee4330963558bf7731b236a37a6a3c4c3064f9e89c4d::config::Config, arg1: &0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        create_order_with_integrator_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, (0 as u16), @0x0, arg7);
    }

    public fun create_order_with_integrator_fee<T0, T1>(arg0: &0xbc33614900f37a4560cee4330963558bf7731b236a37a6a3c4c3064f9e89c4d::config::Config, arg1: &0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: u16, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::assert_enough_gas_was_provided(arg1, &arg3);
        assert_coin_has_non_zero_value<T0>(&arg2);
        assert_coin_types_differ_for_self_transfer<T0, T1>(0x2::tx_context::sender(arg9), arg5);
        0xbc33614900f37a4560cee4330963558bf7731b236a37a6a3c4c3064f9e89c4d::config::assert_public_key_corresponds_to_tx_sender(&arg4, v0);
        let v1 = IntegratorFeeConfig{
            fee_bps       : arg7,
            fee_recipient : arg8,
        };
        let v2 = Order<T0, T1>{
            id                    : 0x2::object::new(arg9),
            user                  : v0,
            recipient             : arg5,
            input_amount          : 0x2::coin::value<T0>(&arg2),
            remaining_balance     : 0x2::coin::into_balance<T0>(arg2),
            gas                   : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            encrypted_fields      : arg6,
            integrator_fee_config : v1,
        };
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::events::emit_created_order_event<T0, T1>(0x2::object::id<Order<T0, T1>>(&v2), v2.user, arg4, v2.recipient, v2.input_amount, 0x2::balance::value<0x2::sui::SUI>(&v2.gas), v2.encrypted_fields, v2.integrator_fee_config.fee_bps, v2.integrator_fee_config.fee_recipient);
        transfer<T0, T1>(v2, arg0, arg4);
    }

    public fun finish_tx<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::Config, arg2: OrderCap<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>) {
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::assert_interacting_with_most_up_to_date_package(arg1);
        assert_current_timestamp_is_less_than_expiry_timestamp(arg4, arg7);
        let OrderCap {
            trade_amount : v0,
            gas_amount   : v1,
        } = arg2;
        let v2 = 0x2::coin::value<T1>(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg0.recipient);
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::events::emit_executed_trade_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg0.user, arg0.recipient, get_trade_type(v2, arg5, arg6, v0, arg0.input_amount), v0, v2, v1);
        assert_input_params_match_encrypted_fields<T0, T1>(arg0, arg5, arg6, arg7, arg8);
    }

    fun get_trade_type(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u8 {
        if (multiply_and_divide(arg1, arg3, arg4) <= arg0) {
            return 0
        } else {
            if (is_set(arg2)) {
                if (arg0 <= multiply_and_divide(arg2, arg3, arg4)) {
                    return 1
                };
            };
            abort 9223374545116200969
        };
    }

    fun init(arg0: ORDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::create_config<ORDER>(&arg0, arg1);
        0x2::transfer::public_transfer<0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::admin::AdminCap>(0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::admin::create_admin_cap<ORDER>(&arg0, arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ORDER>(arg0, arg1), v0);
    }

    fun is_set(arg0: u64) : bool {
        arg0 != 0
    }

    fun multiply_and_divide(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun take_integrator_fee<T0, T1>(arg0: &Order<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.integrator_fee_config.fee_bps;
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, 0x1e63cfab78932e5ac626fb91b9efecf17b8ed887b82ac652a164f78b4eb3e1b4::config::calculate_fee(0x2::coin::value<T0>(arg1), (v0 as u128)), arg2), arg0.integrator_fee_config.fee_recipient);
    }

    // decompiled from Move bytecode v6
}

