module 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::transfer {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct ObjectTransferred has copy, drop {
        object_id: 0x2::object::ID,
        object_type: 0x1::type_name::TypeName,
        recipient: address,
        resource_name: 0x1::string::String,
    }

    struct ObjectTransferredToSender has copy, drop {
        object_id: 0x2::object::ID,
        object_type: 0x1::type_name::TypeName,
        sender: address,
        resource_name: 0x1::string::String,
    }

    struct CoinTransferred has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        resource_name: 0x1::string::String,
    }

    struct CoinTransferredToSender has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
        resource_name: 0x1::string::String,
    }

    struct TransferObject<phantom T0> has drop {
        dummy_field: bool,
    }

    struct TransferToSender<phantom T0> has drop {
        dummy_field: bool,
    }

    struct TransferCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct TransferCoinToSender<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun do_init_transfer<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T2) {
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<TransferObject<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 0);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::string::length(&v4) > 0, 1);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_object<T1, T0, ExecutionProgressWitness>(arg0, arg1, v5, v4);
        let v7 = ObjectTransferred{
            object_id     : 0x2::object::id<T1>(&v6),
            object_type   : 0x1::type_name::get<T1>(),
            recipient     : v3,
            resource_name : v4,
        };
        0x2::event::emit<ObjectTransferred>(v7);
        0x2::transfer::public_transfer<T1>(v6, v3);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, TransferObject<T1>, ExecutionProgressWitness>(arg0, arg1, v8);
    }

    public fun do_init_transfer_coin<T0: store, T1, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T2) {
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<TransferCoin<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 0);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::string::length(&v4) > 0, 1);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_coin<T1, T0, ExecutionProgressWitness>(arg0, arg1, v5, v4);
        let v7 = CoinTransferred{
            coin_type     : 0x1::type_name::get<T1>(),
            amount        : 0x2::coin::value<T1>(&v6),
            recipient     : v3,
            resource_name : v4,
        };
        0x2::event::emit<CoinTransferred>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v3);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, TransferCoin<T1>, ExecutionProgressWitness>(arg0, arg1, v8);
    }

    public fun do_init_transfer_coin_to_sender<T0: store, T1, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T2, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<TransferCoinToSender<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 0);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::string::length(&v3) > 0, 1);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_coin<T1, T0, ExecutionProgressWitness>(arg0, arg1, v4, v3);
        let v6 = 0x2::tx_context::sender(arg3);
        let v7 = CoinTransferredToSender{
            coin_type     : 0x1::type_name::get<T1>(),
            amount        : 0x2::coin::value<T1>(&v5),
            sender        : v6,
            resource_name : v3,
        };
        0x2::event::emit<CoinTransferredToSender>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v6);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, TransferCoinToSender<T1>, ExecutionProgressWitness>(arg0, arg1, v8);
    }

    public fun do_init_transfer_to_sender<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T2, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<TransferToSender<T1>>(v0);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 0);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::string::length(&v3) > 0, 1);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::take_object<T1, T0, ExecutionProgressWitness>(arg0, arg1, v4, v3);
        let v6 = 0x2::tx_context::sender(arg3);
        let v7 = ObjectTransferredToSender{
            object_id     : 0x2::object::id<T1>(&v5),
            object_type   : 0x1::type_name::get<T1>(),
            sender        : v6,
            resource_name : v3,
        };
        0x2::event::emit<ObjectTransferredToSender>(v7);
        0x2::transfer::public_transfer<T1>(v5, v6);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T0, TransferToSender<T1>, ExecutionProgressWitness>(arg0, arg1, v8);
    }

    public fun transfer_coin<T0>() : TransferCoin<T0> {
        TransferCoin<T0>{dummy_field: false}
    }

    public fun transfer_coin_to_sender<T0>() : TransferCoinToSender<T0> {
        TransferCoinToSender<T0>{dummy_field: false}
    }

    public fun transfer_object<T0>() : TransferObject<T0> {
        TransferObject<T0>{dummy_field: false}
    }

    public fun transfer_to_sender<T0>() : TransferToSender<T0> {
        TransferToSender<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

