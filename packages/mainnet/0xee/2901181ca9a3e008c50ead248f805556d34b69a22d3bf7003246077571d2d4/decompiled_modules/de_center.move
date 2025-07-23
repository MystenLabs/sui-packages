module 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_center {
    struct AdminCap has key {
        id: 0x2::object::UID,
        registry: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct LockedConfig has store {
        min_duration: u64,
        max_duration: u64,
        min_return_percentage_rate: u8,
    }

    struct DeCenter<phantom T0> has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        config: LockedConfig,
        minted_escrow: u64,
        locked_total: u64,
        unlocking_total: u64,
        penalty_fee_balance: 0x2::balance::Balance<T0>,
    }

    public fun new<T0>(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : DeCenter<T0> {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.registry, &v2), 101);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.registry, v2, v1);
        assert!(arg1 < arg2, 102);
        assert!(arg3 <= 100, 103);
        let v3 = LockedConfig{
            min_duration               : arg1,
            max_duration               : arg2,
            min_return_percentage_rate : arg3,
        };
        let v4 = DeCenter<T0>{
            id                  : v0,
            versions            : 0x2::vec_set::singleton<u64>(1),
            config              : v3,
            minted_escrow       : 0,
            locked_total        : 0,
            unlocking_total     : 0,
            penalty_fee_balance : 0x2::balance::zero<T0>(),
        };
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events::emit_new_center_event<T0>(v1, arg1, arg2, arg3);
        v4
    }

    public fun add_version<T0>(arg0: &mut DeCenter<T0>, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    fun assert_version<T0>(arg0: &DeCenter<T0>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 1);
    }

    public fun burn<T0>(arg0: &mut DeCenter<T0>, arg1: 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>) {
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::destroy<T0>(arg1);
        arg0.minted_escrow = arg0.minted_escrow - 1;
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events::emit_burn_event<T0>(0x2::object::id<0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>>(&arg1));
    }

    public fun cancel_unlock_request<T0>(arg0: &mut DeCenter<T0>, arg1: &mut 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::cancel_unlock_request<T0>(arg1, arg2, arg3);
        arg0.unlocking_total = arg0.unlocking_total - v0;
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events::emit_cancel_unlock_event<T0>(0x2::object::id<0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>>(arg1), v0, v2 - v1, v1, v2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun center_of<T0>(arg0: &AdminCap) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.registry, &v0)
    }

    public fun claim<T0>(arg0: &mut DeCenter<T0>, arg1: &mut 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2, v3) = 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::claim<T0>(arg1, arg2, arg3);
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T0>(&v4);
        arg0.unlocking_total = arg0.unlocking_total - v6 - v7;
        arg0.locked_total = arg0.locked_total - v6 - v7;
        0x2::balance::join<T0>(&mut arg0.penalty_fee_balance, v4);
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events::emit_claim_event<T0>(0x2::object::id<0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>>(arg1), v6, v7, v2, v3, 0x2::clock::timestamp_ms(arg3));
        v5
    }

    public fun config<T0>(arg0: &DeCenter<T0>) : &LockedConfig {
        &arg0.config
    }

    public fun default<T0>(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DeCenter<T0>>(new<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id       : 0x2::object::new(arg0),
            registry : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lock<T0>(arg0: &mut DeCenter<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::new<T0>(arg1, arg3);
        arg0.minted_escrow = arg0.minted_escrow + 1;
        arg0.locked_total = arg0.locked_total + v0;
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events::emit_lock_event<T0>(0x2::object::id<0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>>(&v1), v0);
        0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::transfer<T0>(v1, arg2);
    }

    public fun locked_total<T0>(arg0: &DeCenter<T0>) : u64 {
        arg0.locked_total
    }

    public fun max_duration(arg0: &LockedConfig) : u64 {
        arg0.max_duration
    }

    public fun min_duration(arg0: &LockedConfig) : u64 {
        arg0.min_duration
    }

    public fun min_return_percentage_rate(arg0: &LockedConfig) : u8 {
        arg0.min_return_percentage_rate
    }

    public fun minted_escrow<T0>(arg0: &DeCenter<T0>) : u64 {
        arg0.minted_escrow
    }

    public fun penalty_fee_balance<T0>(arg0: &DeCenter<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.penalty_fee_balance)
    }

    public fun remove_version<T0>(arg0: &mut DeCenter<T0>, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun request_unlock<T0>(arg0: &mut DeCenter<T0>, arg1: &mut 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 >= arg0.config.min_duration && arg3 <= arg0.config.max_duration, 102);
        if (arg2 > 0) {
            0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::request_unlock<T0>(arg1, arg2, arg3, arg0.config.min_duration, arg0.config.max_duration, arg0.config.min_return_percentage_rate, arg4);
            arg0.unlocking_total = arg0.unlocking_total + arg2;
            0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events::emit_request_unlock_event<T0>(0x2::object::id<0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::de_token::DeToken<T0>>(arg1), arg2, arg3, 0x2::clock::timestamp_ms(arg4), 0x2::clock::timestamp_ms(arg4) + arg3);
        };
    }

    public fun unlocking_total<T0>(arg0: &DeCenter<T0>) : u64 {
        arg0.unlocking_total
    }

    public fun update_duration<T0>(arg0: &mut DeCenter<T0>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        assert!(arg2 < arg3, 102);
        arg0.config.min_duration = arg2;
        arg0.config.max_duration = arg3;
    }

    public fun update_min_return_percentage_rate<T0>(arg0: &mut DeCenter<T0>, arg1: &AdminCap, arg2: u8) {
        assert!(arg2 <= 100, 103);
        arg0.config.min_return_percentage_rate = arg2;
    }

    public fun withdraw_penalty_fee<T0>(arg0: &mut DeCenter<T0>, arg1: &AdminCap, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_version<T0>(arg0);
        0x2::balance::split<T0>(&mut arg0.penalty_fee_balance, arg2)
    }

    // decompiled from Move bytecode v6
}

