module 0x33d6d4e4844a9efdafd7c46efe66009a20bf2d4b06657bee70ad3d44e7eadb78::patience {
    struct PATIENCE has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Director has store, key {
        id: 0x2::object::UID,
        tcap: 0x2::coin::TreasuryCap<PATIENCE>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        last_claim: u64,
        scale: u64,
        claim_fee: u64,
        claim_cap: u64,
        scale_min: u64,
        scale_max: u64,
        cooldown: u64,
        paused: bool,
    }

    struct ClaimEvent has copy, drop {
        claimer: address,
        timestamp: u64,
        amount: u64,
        scale: u64,
    }

    public fun admin_destroy(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun admin_pause(arg0: &mut Director, arg1: &AdminCap) {
        arg0.paused = true;
    }

    public fun admin_resume(arg0: &mut Director, arg1: &AdminCap) {
        arg0.paused = false;
    }

    public fun admin_transfer(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun claim(arg0: &mut Director, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 3);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.last_claim > arg0.cooldown, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= arg0.claim_fee, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, v1);
        let v2 = if (arg0.last_claim == 0) {
            arg0.claim_cap
        } else {
            let v3 = arg0.claim_cap;
            let v4 = (0x2::clock::timestamp_ms(arg2) - arg0.last_claim - arg0.cooldown) * arg0.scale;
            if (v4 > v3) {
                v3
            } else {
                v4
            }
        };
        arg0.last_claim = 0x2::clock::timestamp_ms(arg2);
        arg0.scale = 0x2::random::generate_u64_in_range(&mut v0, arg0.scale_min, arg0.scale_max);
        0x2::coin::mint_and_transfer<PATIENCE>(&mut arg0.tcap, v2, 0x2::tx_context::sender(arg4), arg4);
        emit_claim_event(0x2::clock::timestamp_ms(arg2), v2, arg0.scale, 0x2::tx_context::sender(arg4));
    }

    fun emit_claim_event(arg0: u64, arg1: u64, arg2: u64, arg3: address) {
        let v0 = ClaimEvent{
            claimer   : arg3,
            timestamp : arg0,
            amount    : arg1,
            scale     : arg2,
        };
        0x2::event::emit<ClaimEvent>(v0);
    }

    fun init(arg0: PATIENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<PATIENCE>(arg0, 9, b"PATIENCE", b"Patience", b"The Proof of Patience Coin", 0x1::option::some<0x2::url::Url>(0x33d6d4e4844a9efdafd7c46efe66009a20bf2d4b06657bee70ad3d44e7eadb78::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PATIENCE>>(v2);
        let v3 = Director{
            id          : 0x2::object::new(arg1),
            tcap        : v1,
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            last_claim  : 0,
            scale       : 0,
            claim_fee   : 100000000,
            claim_cap   : 50000000000,
            scale_min   : 1158,
            scale_max   : 13888,
            cooldown    : 30000,
            paused      : false,
        };
        0x2::transfer::share_object<Director>(v3);
    }

    public fun set_claim_cap(arg0: u64, arg1: &mut Director, arg2: &AdminCap) {
        arg1.claim_cap = arg0;
    }

    public fun set_claim_fee(arg0: u64, arg1: &mut Director, arg2: &AdminCap) {
        arg1.claim_fee = arg0;
    }

    public fun set_cooldown(arg0: u64, arg1: &mut Director, arg2: &AdminCap) {
        arg1.cooldown = arg0;
    }

    public fun set_scale_max(arg0: u64, arg1: &mut Director, arg2: &AdminCap) {
        arg1.scale_max = arg0;
    }

    public fun set_scale_min(arg0: u64, arg1: &mut Director, arg2: &AdminCap) {
        arg1.scale_min = arg0;
    }

    public fun withdraw_fee(arg0: &mut Director, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)), arg2)
    }

    // decompiled from Move bytecode v6
}

