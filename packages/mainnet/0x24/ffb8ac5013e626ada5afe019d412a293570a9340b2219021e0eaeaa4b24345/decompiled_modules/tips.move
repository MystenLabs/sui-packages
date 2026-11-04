module 0x24ffb8ac5013e626ada5afe019d412a293570a9340b2219021e0eaeaa4b24345::tips {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReferrerCap has store, key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        tip_fee_bps: u64,
        sub_fee_bps: u64,
        l1_bps: u64,
        l2_bps: u64,
        treasury: address,
        paused: bool,
        referrer_cap_epoch: u64,
        pause_cap_epoch: u64,
        referred_by: 0x2::table::Table<address, address>,
    }

    struct Tipped has copy, drop {
        streamer: address,
        tipper: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        to_streamer: u64,
        fee: u64,
        l1: 0x1::option::Option<address>,
        to_l1: u64,
        l2: 0x1::option::Option<address>,
        to_l2: u64,
        to_treasury: u64,
        message: 0x1::string::String,
    }

    struct ReferrerSet has copy, drop {
        member: address,
        referrer: address,
    }

    struct ReferrerCleared has copy, drop {
        member: address,
    }

    struct FeesChanged has copy, drop {
        tip_fee_bps: u64,
        sub_fee_bps: u64,
        l1_bps: u64,
        l2_bps: u64,
    }

    struct TreasuryChanged has copy, drop {
        treasury: address,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    struct CapsRevoked has copy, drop {
        kind: u8,
        epoch: u64,
    }

    public(friend) fun assert_live(arg0: &Config) {
        assert!(arg0.version == 1, 8);
        assert!(!arg0.paused, 0);
    }

    public fun clear_referrer(arg0: &ReferrerCap, arg1: &mut Config, arg2: address) {
        assert!(arg0.epoch == arg1.referrer_cap_epoch, 7);
        if (0x2::table::contains<address, address>(&arg1.referred_by, arg2)) {
            0x2::table::remove<address, address>(&mut arg1.referred_by, arg2);
            let v0 = ReferrerCleared{member: arg2};
            0x2::event::emit<ReferrerCleared>(v0);
        };
    }

    fun emit_fees(arg0: &Config) {
        let v0 = FeesChanged{
            tip_fee_bps : arg0.tip_fee_bps,
            sub_fee_bps : arg0.sub_fee_bps,
            l1_bps      : arg0.l1_bps,
            l2_bps      : arg0.l2_bps,
        };
        0x2::event::emit<FeesChanged>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ReferrerCap{
            id    : 0x2::object::new(arg0),
            epoch : 0,
        };
        0x2::transfer::public_transfer<ReferrerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = PauseCap{
            id    : 0x2::object::new(arg0),
            epoch : 0,
        };
        0x2::transfer::public_transfer<PauseCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = Config{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            tip_fee_bps        : 500,
            sub_fee_bps        : 1000,
            l1_bps             : 200,
            l2_bps             : 100,
            treasury           : 0x2::tx_context::sender(arg0),
            paused             : false,
            referrer_cap_epoch : 0,
            pause_cap_epoch    : 0,
            referred_by        : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<Config>(v3);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun l1_bps(arg0: &Config) : u64 {
        arg0.l1_bps
    }

    public fun l2_bps(arg0: &Config) : u64 {
        arg0.l2_bps
    }

    public fun max_sub_fee_bps() : u64 {
        1000
    }

    public fun max_tip_fee_bps() : u64 {
        500
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    public fun mint_pause_cap(arg0: &AdminCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) : PauseCap {
        PauseCap{
            id    : 0x2::object::new(arg2),
            epoch : arg1.pause_cap_epoch,
        }
    }

    public fun mint_referrer_cap(arg0: &AdminCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) : ReferrerCap {
        ReferrerCap{
            id    : 0x2::object::new(arg2),
            epoch : arg1.referrer_cap_epoch,
        }
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun package_version() : u64 {
        1
    }

    public fun pause_cap_epoch(arg0: &Config) : u64 {
        arg0.pause_cap_epoch
    }

    public fun pause_cap_epoch_of(arg0: &PauseCap) : u64 {
        arg0.epoch
    }

    fun pay<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1::option::Option<address>, u64, 0x1::option::Option<address>, u64, u64) {
        assert_live(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = mul_bps(v0, arg3);
        let (v2, v3) = uplines(arg0, arg2);
        let v4 = v3;
        let v5 = v2;
        let v6 = if (0x1::option::is_some<address>(&v5)) {
            mul_bps(v0, arg0.l1_bps)
        } else {
            0
        };
        let v7 = if (0x1::option::is_some<address>(&v4)) {
            mul_bps(v0, arg0.l2_bps)
        } else {
            0
        };
        let v8 = v1 - v6 - v7;
        let v9 = &mut arg1;
        send_part<T0>(v9, v6, v5, arg4);
        let v10 = &mut arg1;
        send_part<T0>(v10, v7, v4, arg4);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v8, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        (v0, 0x2::coin::value<T0>(&arg1), v1, v5, v6, v4, v7, v8)
    }

    public(friend) fun pay_sub<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1::option::Option<address>, u64, 0x1::option::Option<address>, u64, u64) {
        pay<T0>(arg0, arg1, arg2, arg0.sub_fee_bps, arg3)
    }

    public fun referrer_cap_epoch(arg0: &Config) : u64 {
        arg0.referrer_cap_epoch
    }

    public fun referrer_cap_epoch_of(arg0: &ReferrerCap) : u64 {
        arg0.epoch
    }

    public fun referrer_of(arg0: &Config, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referred_by, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referred_by, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun revoke_pause_caps(arg0: &AdminCap, arg1: &mut Config) {
        arg1.pause_cap_epoch = arg1.pause_cap_epoch + 1;
        let v0 = CapsRevoked{
            kind  : 1,
            epoch : arg1.pause_cap_epoch,
        };
        0x2::event::emit<CapsRevoked>(v0);
    }

    public fun revoke_referrer_caps(arg0: &AdminCap, arg1: &mut Config) {
        arg1.referrer_cap_epoch = arg1.referrer_cap_epoch + 1;
        let v0 = CapsRevoked{
            kind  : 0,
            epoch : arg1.referrer_cap_epoch,
        };
        0x2::event::emit<CapsRevoked>(v0);
    }

    fun send_part<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), 0x1::option::destroy_some<address>(arg2));
        };
    }

    public fun set_paused(arg0: &PauseCap, arg1: &mut Config, arg2: bool) {
        assert!(arg0.epoch == arg1.pause_cap_epoch, 7);
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_referral_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000 && arg3 <= 10000, 4);
        assert!(arg2 + arg3 <= 0x1::u64::min(arg1.tip_fee_bps, arg1.sub_fee_bps), 4);
        arg1.l1_bps = arg2;
        arg1.l2_bps = arg3;
        emit_fees(arg1);
    }

    public fun set_referrer(arg0: &ReferrerCap, arg1: &mut Config, arg2: address, arg3: address) {
        assert!(arg0.epoch == arg1.referrer_cap_epoch, 7);
        assert!(arg2 != @0x0 && arg3 != @0x0, 6);
        assert!(arg2 != arg3, 5);
        if (0x2::table::contains<address, address>(&arg1.referred_by, arg2)) {
            *0x2::table::borrow_mut<address, address>(&mut arg1.referred_by, arg2) = arg3;
        } else {
            0x2::table::add<address, address>(&mut arg1.referred_by, arg2, arg3);
        };
        let v0 = ReferrerSet{
            member   : arg2,
            referrer : arg3,
        };
        0x2::event::emit<ReferrerSet>(v0);
    }

    public fun set_sub_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 1000, 3);
        assert!(arg1.l1_bps + arg1.l2_bps <= arg2, 4);
        arg1.sub_fee_bps = arg2;
        emit_fees(arg1);
    }

    public fun set_tip_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 500, 3);
        assert!(arg1.l1_bps + arg1.l2_bps <= arg2, 4);
        arg1.tip_fee_bps = arg2;
        emit_fees(arg1);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert!(arg2 != @0x0, 6);
        arg1.treasury = arg2;
        let v0 = TreasuryChanged{treasury: arg2};
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public fun sub_fee_bps(arg0: &Config) : u64 {
        arg0.sub_fee_bps
    }

    public fun tip<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(0x1::string::length(&arg3) <= 200, 2);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = pay<T0>(arg0, arg1, arg2, arg0.tip_fee_bps, arg4);
        let v8 = Tipped{
            streamer    : arg2,
            tipper      : 0x2::tx_context::sender(arg4),
            coin_type   : 0x1::type_name::with_defining_ids<T0>(),
            amount      : v0,
            to_streamer : v1,
            fee         : v2,
            l1          : v3,
            to_l1       : v4,
            l2          : v5,
            to_l2       : v6,
            to_treasury : v7,
            message     : arg3,
        };
        0x2::event::emit<Tipped>(v8);
    }

    public fun tip_fee_bps(arg0: &Config) : u64 {
        arg0.tip_fee_bps
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun uplines(arg0: &Config, arg1: address) : (0x1::option::Option<address>, 0x1::option::Option<address>) {
        if (!0x2::table::contains<address, address>(&arg0.referred_by, arg1)) {
            return (0x1::option::none<address>(), 0x1::option::none<address>())
        };
        let v0 = *0x2::table::borrow<address, address>(&arg0.referred_by, arg1);
        if (v0 == arg1) {
            return (0x1::option::none<address>(), 0x1::option::none<address>())
        };
        if (!0x2::table::contains<address, address>(&arg0.referred_by, v0)) {
            return (0x1::option::some<address>(v0), 0x1::option::none<address>())
        };
        let v1 = *0x2::table::borrow<address, address>(&arg0.referred_by, v0);
        if (v1 == arg1 || v1 == v0) {
            return (0x1::option::some<address>(v0), 0x1::option::none<address>())
        };
        (0x1::option::some<address>(v0), 0x1::option::some<address>(v1))
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

