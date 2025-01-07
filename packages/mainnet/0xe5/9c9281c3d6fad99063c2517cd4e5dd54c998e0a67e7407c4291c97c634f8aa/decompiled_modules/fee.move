module 0xe59c9281c3d6fad99063c2517cd4e5dd54c998e0a67e7407c4291c97c634f8aa::fee {
    struct FeeInfo has store {
        token_fee: u64,
        fixed_native_fee_amount: u64,
        dzap_token_share: u64,
        dzap_fixed_native_share: u64,
    }

    struct IntegratorInfo has store {
        status: bool,
        fee_info: 0x2::vec_map::VecMap<0x1::string::String, FeeInfo>,
    }

    struct FeesStorage has store, key {
        id: 0x2::object::UID,
        integrator_info: 0x2::vec_map::VecMap<address, IntegratorInfo>,
        max_token_fee: u128,
        max_fixed_native_fee_amount: u64,
        protocol_fee_vault: address,
        initialized: bool,
    }

    struct NewIntegratorInfo has copy, drop {
        integrator: address,
        token_fee: u64,
        fixed_native_fee_amount: u64,
        dzap_token_share: u64,
        dzap_fixed_native_share: u64,
    }

    struct CalcTokenFees has copy, drop {
        token_fee_amount: u64,
        dzap_share: u64,
    }

    public fun accrue_fixed_native_fees(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &FeesStorage, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get<address, IntegratorInfo>(&arg2.integrator_info, &arg1);
        assert!(v0.status == true, 0);
        0x2::vec_map::get<0x1::string::String, FeeInfo>(&v0.fee_info, &arg3);
        let (v1, v2) = calc_fixed_native_fees(arg1, arg2, arg3, arg4);
        if (v1 > 0) {
            0xe59c9281c3d6fad99063c2517cd4e5dd54c998e0a67e7407c4291c97c634f8aa::asset::transfer_sui_coin(arg0, v1 - v2, arg1, arg4);
        };
        if (v2 > 0) {
            0xe59c9281c3d6fad99063c2517cd4e5dd54c998e0a67e7407c4291c97c634f8aa::asset::transfer_sui_coin(arg0, v2, arg2.protocol_fee_vault, arg4);
        };
    }

    public fun accrue_token_fees<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &FeesStorage, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get<address, IntegratorInfo>(&arg3.integrator_info, &arg1);
        assert!(v0.status == true, 0);
        0x2::vec_map::get<0x1::string::String, FeeInfo>(&v0.fee_info, &arg4);
        let (v1, v2) = calc_token_fees(arg1, arg2, arg3, arg4, arg5);
        if (v1 > 0) {
            0xe59c9281c3d6fad99063c2517cd4e5dd54c998e0a67e7407c4291c97c634f8aa::asset::transfer_coin<T0>(arg0, v1 - v2, arg1, arg5);
        };
        if (v2 > 0) {
            0xe59c9281c3d6fad99063c2517cd4e5dd54c998e0a67e7407c4291c97c634f8aa::asset::transfer_coin<T0>(arg0, v2, arg3.protocol_fee_vault, arg5);
        };
    }

    public fun calc_fixed_native_fees(arg0: address, arg1: &FeesStorage, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::vec_map::get<0x1::string::String, FeeInfo>(&0x2::vec_map::get<address, IntegratorInfo>(&arg1.integrator_info, &arg0).fee_info, &arg2);
        let v1 = 0;
        if (v0.fixed_native_fee_amount > 0) {
            v1 = v0.fixed_native_fee_amount * v0.dzap_fixed_native_share / 1000000;
        };
        (v0.fixed_native_fee_amount, v1)
    }

    public fun calc_token_fees(arg0: address, arg1: u64, arg2: &FeesStorage, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::vec_map::get<0x1::string::String, FeeInfo>(&0x2::vec_map::get<address, IntegratorInfo>(&arg2.integrator_info, &arg0).fee_info, &arg3);
        let v1 = 0;
        let v2 = v0.token_fee * arg1 / 1000000;
        if (v2 > 0) {
            v1 = v2 * v0.dzap_token_share / 1000000;
        };
        (v2, v1)
    }

    public fun dzap_fixed_native_share(arg0: address, arg1: &FeesStorage, arg2: 0x1::string::String) : u64 {
        0x2::vec_map::get<0x1::string::String, FeeInfo>(&0x2::vec_map::get<address, IntegratorInfo>(&arg1.integrator_info, &arg0).fee_info, &arg2).dzap_fixed_native_share
    }

    public fun dzap_token_share(arg0: address, arg1: &FeesStorage, arg2: 0x1::string::String) : u64 {
        0x2::vec_map::get<0x1::string::String, FeeInfo>(&0x2::vec_map::get<address, IntegratorInfo>(&arg1.integrator_info, &arg0).fee_info, &arg2).dzap_token_share
    }

    public fun fixed_native_fee_amount(arg0: address, arg1: &FeesStorage, arg2: 0x1::string::String) : u64 {
        0x2::vec_map::get<0x1::string::String, FeeInfo>(&0x2::vec_map::get<address, IntegratorInfo>(&arg1.integrator_info, &arg0).fee_info, &arg2).fixed_native_fee_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeesStorage{
            id                          : 0x2::object::new(arg0),
            integrator_info             : 0x2::vec_map::empty<address, IntegratorInfo>(),
            max_token_fee               : 0,
            max_fixed_native_fee_amount : 0,
            protocol_fee_vault          : 0x2::tx_context::sender(arg0),
            initialized                 : true,
        };
        0x2::transfer::share_object<FeesStorage>(v0);
    }

    public entry fun set_integrator(arg0: &mut FeesStorage, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeInfo{
            token_fee               : arg2,
            fixed_native_fee_amount : arg3,
            dzap_token_share        : arg4,
            dzap_fixed_native_share : arg5,
        };
        let v1 = IntegratorInfo{
            status   : true,
            fee_info : 0x2::vec_map::empty<0x1::string::String, FeeInfo>(),
        };
        0x2::vec_map::insert<0x1::string::String, FeeInfo>(&mut v1.fee_info, arg1, v0);
        0x2::vec_map::insert<address, IntegratorInfo>(&mut arg0.integrator_info, arg6, v1);
        let v2 = NewIntegratorInfo{
            integrator              : arg6,
            token_fee               : arg2,
            fixed_native_fee_amount : arg3,
            dzap_token_share        : arg4,
            dzap_fixed_native_share : arg5,
        };
        0x2::event::emit<NewIntegratorInfo>(v2);
    }

    public fun token_fee(arg0: address, arg1: &FeesStorage, arg2: 0x1::string::String) : u64 {
        0x2::vec_map::get<0x1::string::String, FeeInfo>(&0x2::vec_map::get<address, IntegratorInfo>(&arg1.integrator_info, &arg0).fee_info, &arg2).token_fee
    }

    // decompiled from Move bytecode v6
}

