module 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector {
    struct FEE_COLLECTOR has drop {
        dummy_field: bool,
    }

    struct FeeCollectorConfig has key {
        id: 0x2::object::UID,
        default_fee: u64,
        default_fee_token: 0x1::type_name::TypeName,
        custom_fees_fixed: 0x2::table::Table<address, u64>,
        custom_fee_tokens: 0x2::table::Table<address, 0x1::type_name::TypeName>,
    }

    struct Treasury<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    struct DefaultFeeSet has copy, drop {
        fee: u64,
    }

    struct CustomFeeSetFixed has copy, drop {
        distributor_address: address,
        fixed_fee: u64,
    }

    struct FeeCollectorConfigCreated has copy, drop {
        object_address: address,
    }

    public fun collect_fee<T0>(arg0: &mut FeeCollectorConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Treasury<T0>>(&mut arg0.id, v0).balance, 0x2::coin::into_balance<T0>(arg1));
        } else {
            let v1 = Treasury<T0>{balance: 0x2::coin::into_balance<T0>(arg1)};
            0x2::dynamic_field::add<0x1::type_name::TypeName, Treasury<T0>>(&mut arg0.id, v0, v1);
        };
    }

    public entry fun get_fee(arg0: &FeeCollectorConfig, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.custom_fees_fixed, arg1)) {
            let v0 = *0x2::table::borrow<address, u64>(&arg0.custom_fees_fixed, arg1);
            if (v0 > 0) {
                return v0
            };
        };
        arg0.default_fee
    }

    public entry fun get_fee_token(arg0: &FeeCollectorConfig, arg1: address) : 0x1::type_name::TypeName {
        if (0x2::table::contains<address, 0x1::type_name::TypeName>(&arg0.custom_fee_tokens, arg1)) {
            return *0x2::table::borrow<address, 0x1::type_name::TypeName>(&arg0.custom_fee_tokens, arg1)
        };
        arg0.default_fee_token
    }

    public entry fun get_treasury_balance<T0>(arg0: &FeeCollectorConfig) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, Treasury<T0>>(&arg0.id, v0).balance)
        } else {
            0
        }
    }

    fun init(arg0: FEE_COLLECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<FEE_COLLECTOR>(&arg0), 0);
        let v0 = FeeCollectorConfig{
            id                : 0x2::object::new(arg1),
            default_fee       : 0,
            default_fee_token : 0x1::type_name::get<0x2::sui::SUI>(),
            custom_fees_fixed : 0x2::table::new<address, u64>(arg1),
            custom_fee_tokens : 0x2::table::new<address, 0x1::type_name::TypeName>(arg1),
        };
        let v1 = FeeCollectorConfigCreated{object_address: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<FeeCollectorConfigCreated>(v1);
        0x2::transfer::share_object<FeeCollectorConfig>(v0);
    }

    public entry fun set_custom_fee_fixed(arg0: &mut FeeCollectorConfig, arg1: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OwnerCap<0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OWNABLE>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.custom_fees_fixed, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.custom_fees_fixed, arg2) = arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.custom_fees_fixed, arg2, arg3);
        };
        let v0 = CustomFeeSetFixed{
            distributor_address : arg2,
            fixed_fee           : arg3,
        };
        0x2::event::emit<CustomFeeSetFixed>(v0);
    }

    public entry fun set_custom_fee_token<T0>(arg0: &mut FeeCollectorConfig, arg1: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OwnerCap<0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OWNABLE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, 0x1::type_name::TypeName>(&arg0.custom_fee_tokens, arg2)) {
            *0x2::table::borrow_mut<address, 0x1::type_name::TypeName>(&mut arg0.custom_fee_tokens, arg2) = 0x1::type_name::get<T0>();
        } else {
            0x2::table::add<address, 0x1::type_name::TypeName>(&mut arg0.custom_fee_tokens, arg2, 0x1::type_name::get<T0>());
        };
    }

    public entry fun set_default_fee(arg0: &mut FeeCollectorConfig, arg1: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OwnerCap<0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OWNABLE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.default_fee = arg2;
        let v0 = DefaultFeeSet{fee: arg2};
        0x2::event::emit<DefaultFeeSet>(v0);
    }

    public entry fun set_default_fee_token<T0>(arg0: &mut FeeCollectorConfig, arg1: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OwnerCap<0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OWNABLE>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.default_fee_token = 0x1::type_name::get<T0>();
    }

    public entry fun version() : 0x1::string::String {
        0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::version::with_module(b"Fee Collector")
    }

    public entry fun withdraw_fee<T0>(arg0: &mut FeeCollectorConfig, arg1: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OwnerCap<0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable::OWNABLE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Treasury<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(&v1.balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

