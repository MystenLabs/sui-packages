module 0x8cde30c2af7523193689e2f3eaca6dc4fadf6fd486471a6c31b14bc9db5164b2::drift {
    struct Drift has key {
        id: 0x2::object::UID,
        cast_count: u64,
        lh_count: u64,
        created_at: u64,
    }

    struct CastIndexed has copy, drop {
        cast_id: address,
        hook: vector<u8>,
        vessel_tier: u8,
        created_at: u64,
        expires_at: u64,
        mode: u8,
    }

    struct LighthouseIndexed has copy, drop {
        cast_id: address,
        lighthouse_id: address,
        birth_path: u8,
        born_at: u64,
    }

    public fun cast_count(arg0: &Drift) : u64 {
        arg0.cast_count
    }

    public fun index_cast(arg0: &mut Drift, arg1: address, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg0.created_at == 0) {
            arg0.created_at = v0;
        };
        arg0.cast_count = arg0.cast_count + 1;
        let v1 = CastIndexed{
            cast_id     : arg1,
            hook        : arg2,
            vessel_tier : arg3,
            created_at  : v0,
            expires_at  : arg4,
            mode        : arg5,
        };
        0x2::event::emit<CastIndexed>(v1);
    }

    public fun index_lighthouse(arg0: &mut Drift, arg1: address, arg2: address, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        arg0.lh_count = arg0.lh_count + 1;
        let v0 = LighthouseIndexed{
            cast_id       : arg1,
            lighthouse_id : arg2,
            birth_path    : arg3,
            born_at       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LighthouseIndexed>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Drift{
            id         : 0x2::object::new(arg0),
            cast_count : 0,
            lh_count   : 0,
            created_at : 0,
        };
        0x2::transfer::share_object<Drift>(v0);
    }

    public fun lh_count(arg0: &Drift) : u64 {
        arg0.lh_count
    }

    // decompiled from Move bytecode v7
}

