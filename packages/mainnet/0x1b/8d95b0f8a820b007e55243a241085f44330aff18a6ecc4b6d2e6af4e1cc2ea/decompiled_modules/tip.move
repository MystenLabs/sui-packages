module 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_cap: u64,
        free_below: u64,
        fee_recipient: address,
    }

    struct TipEvent has copy, drop {
        tipper: address,
        creator: address,
        referrer: address,
        amount: u64,
        creator_amount: u64,
        referrer_amount: u64,
        fee_amount: u64,
    }

    struct MintFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun tip(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg3 != @0x0 && arg4 > 0;
        assert!(!v1 || arg3 != v0 && arg3 != arg2, 4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let (v3, v4, v5) = quote(arg0, v2, v1, arg4);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v5, arg5), arg0.fee_recipient);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg5), arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2);
        let v6 = if (v1) {
            arg3
        } else {
            @0x0
        };
        let v7 = TipEvent{
            tipper          : v0,
            creator         : arg2,
            referrer        : v6,
            amount          : v2,
            creator_amount  : v3,
            referrer_amount : v4,
            fee_amount      : v5,
        };
        0x2::event::emit<TipEvent>(v7);
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            fee_bps       : 100,
            fee_cap       : 1000000000,
            free_below    : 1000000000,
            fee_recipient : v0,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun mint_fee_bps(arg0: &Config) : u64 {
        let v0 = MintFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MintFeeKey>(&arg0.id, v0)) {
            let v2 = MintFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MintFeeKey, u64>(&arg0.id, v2)
        } else {
            250
        }
    }

    public fun quote(arg0: &Config, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64) {
        assert!(arg1 > 0, 1);
        assert!(arg3 <= 2000, 3);
        let v0 = if (arg1 < arg0.free_below) {
            0
        } else {
            (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64)
        };
        let v1 = v0;
        if (v0 > arg0.fee_cap) {
            v1 = arg0.fee_cap;
        };
        let v2 = if (arg2) {
            (((arg1 as u128) * (arg3 as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        (arg1 - v1 - v2, v2, v1)
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= 500, 2);
        arg1.fee_bps = arg2;
        arg1.fee_cap = arg3;
        arg1.free_below = arg4;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun set_mint_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 500, 2);
        let v0 = MintFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MintFeeKey>(&arg1.id, v0)) {
            let v1 = MintFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MintFeeKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = MintFeeKey{dummy_field: false};
            0x2::dynamic_field::add<MintFeeKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

