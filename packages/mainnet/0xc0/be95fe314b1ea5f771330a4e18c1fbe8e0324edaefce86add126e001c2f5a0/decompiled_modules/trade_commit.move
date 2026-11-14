module 0xc0be95fe314b1ea5f771330a4e18c1fbe8e0324edaefce86add126e001c2f5a0::trade_commit {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        signers: vector<address>,
    }

    struct InitCap has key {
        id: 0x2::object::UID,
    }

    struct TradeCommitted has copy, drop {
        trade_id: u128,
        user_id: u64,
        symbol_code: u16,
        side: u8,
        price_e8: u64,
        qty_e8: u64,
        fee_e8: u64,
        protocol_fee_e8: u64,
        ts_ms: u64,
        signer: address,
    }

    struct AuthorizedSignerAdded has copy, drop {
        signer: address,
    }

    struct AuthorizedSignerRemoved has copy, drop {
        signer: address,
    }

    struct PausedSet has copy, drop {
        paused: bool,
    }

    struct OwnershipTransferred has copy, drop {
        previous_admin: address,
        new_admin: address,
    }

    public fun add_authorized_signer(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (arg1 == @0x0) {
            abort 9
        };
        if (is_authorized_signer(arg0, arg1)) {
            abort 4
        };
        if (0x1::vector::length<address>(&arg0.signers) >= 64) {
            abort 7
        };
        0x1::vector::push_back<address>(&mut arg0.signers, arg1);
        let v0 = AuthorizedSignerAdded{signer: arg1};
        0x2::event::emit<AuthorizedSignerAdded>(v0);
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            abort 1
        };
    }

    public fun commit_trade(arg0: &Config, arg1: u128, arg2: u64, arg3: u16, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        if (arg0.paused) {
            abort 2
        };
        if (!is_authorized_signer(arg0, v0)) {
            abort 3
        };
        let v1 = TradeCommitted{
            trade_id        : arg1,
            user_id         : arg2,
            symbol_code     : arg3,
            side            : arg4,
            price_e8        : arg5,
            qty_e8          : arg6,
            fee_e8          : arg7,
            protocol_fee_e8 : arg8,
            ts_ms           : arg9,
            signer          : v0,
        };
        0x2::event::emit<TradeCommitted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize(arg0: InitCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == @0x0) {
            abort 8
        };
        if (arg2 == @0x0) {
            abort 9
        };
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg2);
        let v1 = Config{
            id      : 0x2::object::new(arg3),
            admin   : arg1,
            paused  : false,
            signers : v0,
        };
        let v2 = AuthorizedSignerAdded{signer: arg2};
        0x2::event::emit<AuthorizedSignerAdded>(v2);
        0x2::transfer::share_object<Config>(v1);
        let InitCap { id: v3 } = arg0;
        0x2::object::delete(v3);
    }

    public fun is_authorized_signer(arg0: &Config, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.signers, &arg1)
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun remove_authorized_signer(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (0x1::vector::length<address>(&arg0.signers) == 1) {
            abort 6
        };
        0x1::vector::remove<address>(&mut arg0.signers, signer_index(arg0, arg1));
        let v0 = AuthorizedSignerRemoved{signer: arg1};
        0x2::event::emit<AuthorizedSignerRemoved>(v0);
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.paused = arg1;
        let v0 = PausedSet{paused: arg1};
        0x2::event::emit<PausedSet>(v0);
    }

    public fun signer_count(arg0: &Config) : u64 {
        0x1::vector::length<address>(&arg0.signers)
    }

    fun signer_index(arg0: &Config, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.signers)) {
            if (*0x1::vector::borrow<address>(&arg0.signers, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public fun transfer_admin(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (arg1 == @0x0) {
            abort 8
        };
        arg0.admin = arg1;
        let v0 = OwnershipTransferred{
            previous_admin : arg0.admin,
            new_admin      : arg1,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

