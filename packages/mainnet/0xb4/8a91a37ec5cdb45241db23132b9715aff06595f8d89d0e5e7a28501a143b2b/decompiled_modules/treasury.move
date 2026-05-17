module 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
    }

    public fun withdraw_all<T0>(arg0: &mut Treasury<T0>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_treasury_withdraw(), 0x2::object::id<Treasury<T0>>(arg0), withdraw_payload_hash(arg3, arg4), arg5);
        assert!(0x2::tx_context::sender(arg6) == arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_wrong_recipient());
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) <= arg4, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_amount_exceeds_max());
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance)
    }

    public fun id<T0>(arg0: &Treasury<T0>) : 0x2::object::ID {
        0x2::object::id<Treasury<T0>>(arg0)
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        Treasury<T0>{
            id                : 0x2::object::new(arg2),
            market_core_id    : arg0,
            adapter_auth_type : arg1,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected   : 0,
        }
    }

    public fun balance_value<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun collect_fee<T0, T1: drop>(arg0: &mut Treasury<T0>, arg1: &T1, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u16) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg3 <= 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::constants::protocol_max_fee_bps(), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_invalid_bps());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        if (v0 == 0 || arg3 == 0) {
            return (arg2, 0)
        };
        let v1 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::math_ext::mul_div_down_u64(v0, (arg3 as u64), (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::constants::bps_denominator() as u64));
        if (v1 == 0) {
            return (arg2, 0)
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v1));
        arg0.total_collected = arg0.total_collected + v1;
        (arg2, v1)
    }

    public fun market_core_id<T0>(arg0: &Treasury<T0>) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun op_claim() : u8 {
        1
    }

    public fun op_combine() : u8 {
        3
    }

    public fun op_pt_vault_redeem() : u8 {
        6
    }

    public fun op_redeem() : u8 {
        2
    }

    public fun op_vault_claim() : u8 {
        4
    }

    public fun op_vault_redeem() : u8 {
        5
    }

    public fun share<T0>(arg0: Treasury<T0>) {
        0x2::transfer::share_object<Treasury<T0>>(arg0);
    }

    public fun total_collected<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.total_collected
    }

    public fun withdraw_payload_hash(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"nemo:treasury_withdraw:v1";
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::append_bcs<address>(&mut v0, &arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::append_bcs<u64>(&mut v0, &arg1);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(v0)
    }

    // decompiled from Move bytecode v7
}

