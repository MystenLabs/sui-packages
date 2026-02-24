module 0x4378b5bf4c21d313150634d529218ea11166ca113a2869a31c88deb4bb8c2417::payfrica_lite_v2 {
    struct FeeTier has copy, drop, store {
        min_amount: u64,
        max_amount: u64,
        fee_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        fee_address: address,
        onramp_tiers: 0x2::table::Table<0x1::type_name::TypeName, vector<FeeTier>>,
        offramp_tiers: 0x2::table::Table<0x1::type_name::TypeName, vector<FeeTier>>,
    }

    struct OnRampEvent has copy, drop {
        receiver: address,
        amount: u64,
        fee: u64,
        coin_type: 0x1::type_name::TypeName,
        fiat: 0x1::string::String,
        timestamp: u64,
    }

    struct OffRampEvent has copy, drop {
        sender: address,
        amount: u64,
        fee: u64,
        coin_type: 0x1::type_name::TypeName,
        fiat: 0x1::string::String,
        timestamp: u64,
    }

    struct OffRampRefundEvent has copy, drop {
        receiver: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        fiat: 0x1::string::String,
        timestamp: u64,
    }

    public fun add_offramp_tier<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u64>, arg3: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::vector::borrow<u64>(&arg2, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg2, 1);
        if (!0x2::table::contains<0x1::type_name::TypeName, vector<FeeTier>>(&arg1.offramp_tiers, v0)) {
            0x2::table::add<0x1::type_name::TypeName, vector<FeeTier>>(&mut arg1.offramp_tiers, v0, 0x1::vector::empty<FeeTier>());
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, vector<FeeTier>>(&mut arg1.offramp_tiers, v0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<FeeTier>(v3)) {
            let v5 = 0x1::vector::borrow_mut<FeeTier>(v3, v4);
            if (v5.min_amount == v1 && v5.max_amount == v2) {
                v5.fee_bps = arg3;
                return
            };
            let v6 = v5.max_amount != 0 && v5.max_amount <= v1;
            let v7 = v2 != 0 && v2 <= v5.min_amount;
            assert!(v6 || v7, 3);
            v4 = v4 + 1;
        };
        let v8 = FeeTier{
            min_amount : v1,
            max_amount : v2,
            fee_bps    : arg3,
        };
        0x1::vector::push_back<FeeTier>(v3, v8);
    }

    public fun add_onramp_tier<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u64>, arg3: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::vector::borrow<u64>(&arg2, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg2, 1);
        if (!0x2::table::contains<0x1::type_name::TypeName, vector<FeeTier>>(&arg1.onramp_tiers, v0)) {
            0x2::table::add<0x1::type_name::TypeName, vector<FeeTier>>(&mut arg1.onramp_tiers, v0, 0x1::vector::empty<FeeTier>());
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, vector<FeeTier>>(&mut arg1.onramp_tiers, v0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<FeeTier>(v3)) {
            let v5 = 0x1::vector::borrow_mut<FeeTier>(v3, v4);
            if (v5.min_amount == v1 && v5.max_amount == v2) {
                v5.fee_bps = arg3;
                return
            };
            let v6 = v5.max_amount != 0 && v5.max_amount <= v1;
            let v7 = v2 != 0 && v2 <= v5.min_amount;
            assert!(v6 || v7, 3);
            v4 = v4 + 1;
        };
        let v8 = FeeTier{
            min_amount : v1,
            max_amount : v2,
            fee_bps    : arg3,
        };
        0x1::vector::push_back<FeeTier>(v3, v8);
    }

    public fun clear_offramp_tiers<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<FeeTier>>(&arg1.offramp_tiers, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, vector<FeeTier>>(&mut arg1.offramp_tiers, v0) = 0x1::vector::empty<FeeTier>();
        };
    }

    public fun clear_onramp_tiers<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<FeeTier>>(&arg1.onramp_tiers, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, vector<FeeTier>>(&mut arg1.onramp_tiers, v0) = 0x1::vector::empty<FeeTier>();
        };
    }

    fun compute_fee(arg0: &vector<FeeTier>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeTier>(arg0)) {
            let v1 = 0x1::vector::borrow<FeeTier>(arg0, v0);
            let v2 = v1.max_amount == 0 || arg1 < v1.max_amount;
            if (arg1 >= v1.min_amount && v2) {
                return arg1 * v1.fee_bps / 10000
            };
            v0 = v0 + 1;
        };
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            fee_address   : @0xdcfd7fd641a0d74b8fb83ae9949c560eb6c183a3d8c3b975e697527eada62b45,
            onramp_tiers  : 0x2::table::new<0x1::type_name::TypeName, vector<FeeTier>>(arg0),
            offramp_tiers : 0x2::table::new<0x1::type_name::TypeName, vector<FeeTier>>(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun off_ramp<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, vector<FeeTier>>(&arg0.offramp_tiers, v1)) {
            compute_fee(0x2::table::borrow<0x1::type_name::TypeName, vector<FeeTier>>(&arg0.offramp_tiers, v1), v0)
        } else {
            0
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg4), arg0.fee_address);
        };
        let v3 = OffRampEvent{
            sender    : 0x2::tx_context::sender(arg4),
            amount    : v0,
            fee       : v2,
            coin_type : v1,
            fiat      : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OffRampEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x7aab130dfb21a710d53b8c17ec3e0783fc4f57d8d9dea1082154cd647c0e2f34);
    }

    public fun on_ramp<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, vector<FeeTier>>(&arg0.onramp_tiers, v1)) {
            compute_fee(0x2::table::borrow<0x1::type_name::TypeName, vector<FeeTier>>(&arg0.onramp_tiers, v1), v0)
        } else {
            0
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg5), arg0.fee_address);
        };
        let v3 = OnRampEvent{
            receiver  : arg3,
            amount    : v0,
            fee       : v2,
            coin_type : v1,
            fiat      : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<OnRampEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
    }

    public fun refund<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        let v0 = OffRampRefundEvent{
            receiver  : arg3,
            amount    : 0x2::coin::value<T0>(&arg1),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            fiat      : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<OffRampRefundEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
    }

    public fun set_fee_address(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_address = arg2;
    }

    // decompiled from Move bytecode v6
}

