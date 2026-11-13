module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument {
    struct InstrumentSpec has copy, drop, store {
        product: u8,
        underlying: u32,
        expiry_ms: u64,
        lot_payout: u64,
        collateral: 0x1::type_name::TypeName,
        terms: vector<u8>,
    }

    struct Position has drop, store {
        amount: u64,
        is_short: bool,
        basis: u64,
    }

    struct Refund has copy, drop, store {
        pool: u64,
        total: u128,
        pays_basis: bool,
    }

    struct Instrument has store {
        spec: InstrumentSpec,
        collateral: u64,
        open_interest: u64,
        short_lots: u64,
        positions: 0x2::table::Table<address, Position>,
        payout_per_lot: 0x1::option::Option<u64>,
        settled_at_ms: u64,
        claims_open_ms: u64,
        long_basis: u128,
        short_basis: u128,
        refund: 0x1::option::Option<Refund>,
        settled_claims: u64,
        gap_deficit: u128,
        gap_surplus: u128,
    }

    public(friend) fun new(arg0: InstrumentSpec, arg1: &mut 0x2::tx_context::TxContext) : Instrument {
        Instrument{
            spec           : arg0,
            collateral     : 0,
            open_interest  : 0,
            short_lots     : 0,
            positions      : 0x2::table::new<address, Position>(arg1),
            payout_per_lot : 0x1::option::none<u64>(),
            settled_at_ms  : 0,
            claims_open_ms : 0,
            long_basis     : 0,
            short_basis    : 0,
            refund         : 0x1::option::none<Refund>(),
            settled_claims : 0,
            gap_deficit    : 0,
            gap_surplus    : 0,
        }
    }

    fun add_basis(arg0: &mut Instrument, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.short_basis = arg0.short_basis + (arg2 as u128);
        } else {
            arg0.long_basis = arg0.long_basis + (arg2 as u128);
        };
    }

    public(friend) fun apply_fill(arg0: &mut Instrument, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: bool) : (u64, u64) {
        assert!(0x1::option::is_none<Refund>(&arg0.refund), 308);
        let v0 = 0x1::u64::min(short_of(arg0, arg1), arg3);
        let v1 = 0x1::u64::min(long_of(arg0, arg2), arg3);
        let v2 = take_off(arg0, arg1, true, v0);
        let v3 = take_off(arg0, arg2, false, v1);
        let v4 = arg3 - v0;
        let v5 = arg3 - v1;
        let v6 = 0x1::u64::min(v4, v1);
        let v7 = part(arg4, v4 - v6, arg3);
        let v8 = if (v1 == 0) {
            0
        } else {
            part(v3, v6, v1)
        };
        let v9 = if (v0 == 0) {
            0
        } else {
            part(v2, 0x1::u64::min(v5, v0), v0)
        };
        if (arg5 && v1 - v6 > 0) {
            let v10 = ((v3 - v8) as u128);
            let v11 = ((v2 - v9) as u128);
            if (v11 > v10) {
                arg0.gap_deficit = arg0.gap_deficit + v11 - v10;
            } else {
                arg0.gap_surplus = arg0.gap_surplus + v10 - v11;
            };
        };
        put_on(arg0, arg1, false, v4, v8 + v7);
        put_on(arg0, arg2, true, v5, v9 + v7);
        let v12 = lots_value(&arg0.spec, v0);
        let v13 = lots_value(&arg0.spec, v5);
        arg0.open_interest = arg0.open_interest + v4 - v1;
        arg0.short_lots = arg0.short_lots + v5 - v0;
        arg0.collateral = arg0.collateral + v13 - v12;
        (v12, v13)
    }

    public fun basis(arg0: &Instrument, arg1: address) : u64 {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Position>(&arg0.positions, arg1).basis
    }

    public fun basis_gap(arg0: &Instrument) : (u128, u128) {
        (arg0.gap_deficit, arg0.gap_surplus)
    }

    public fun claims_open_ms(arg0: &Instrument) : u64 {
        arg0.claims_open_ms
    }

    public fun collateral(arg0: &Instrument) : u64 {
        arg0.collateral
    }

    public fun collateral_coin(arg0: &InstrumentSpec) : 0x1::type_name::TypeName {
        arg0.collateral
    }

    public(friend) fun destroy(arg0: Instrument) : (InstrumentSpec, u64) {
        let Instrument {
            spec           : v0,
            collateral     : v1,
            open_interest  : _,
            short_lots     : _,
            positions      : v4,
            payout_per_lot : v5,
            settled_at_ms  : _,
            claims_open_ms : _,
            long_basis     : _,
            short_basis    : _,
            refund         : v10,
            settled_claims : _,
            gap_deficit    : _,
            gap_surplus    : _,
        } = arg0;
        let v14 = v10;
        let v15 = v5;
        let v16 = v4;
        assert!(0x1::option::is_some<u64>(&v15) || 0x1::option::is_some<Refund>(&v14), 305);
        assert!(0x2::table::length<address, Position>(&v16) == 0, 306);
        0x2::table::destroy_empty<address, Position>(v16);
        (v0, v1)
    }

    public(friend) fun enter_refund(arg0: &mut Instrument, arg1: 0x1::type_name::TypeName) {
        assert!(0x1::option::is_none<Refund>(&arg0.refund), 308);
        let v0 = arg0.spec.collateral == arg1;
        let v1 = if (v0) {
            arg0.long_basis
        } else {
            0
        };
        let v2 = (arg0.spec.lot_payout as u128) * (arg0.short_lots as u128);
        let v3 = if (v0) {
            v2 - 0x1::u128::min(arg0.short_basis, v2)
        } else {
            v2
        };
        let v4 = Refund{
            pool       : arg0.collateral,
            total      : v1 + v3,
            pays_basis : v0,
        };
        arg0.refund = 0x1::option::some<Refund>(v4);
    }

    public fun expiry_ms(arg0: &InstrumentSpec) : u64 {
        arg0.expiry_ms
    }

    public fun grid_spec(arg0: u256, arg1: 0x1::type_name::TypeName) : InstrumentSpec {
        assert!(arg0 >> 248 < 253, 301);
        let v0 = ((arg0 >> 160 & 4294967295) as u64);
        assert!(v0 > ((arg0 >> 192 & 4294967295) as u64), 301);
        assert!(((arg0 >> 96 & 18446744073709551615) as u64) > ((arg0 >> 32 & 18446744073709551615) as u64), 301);
        assert!(arg0 & 4294967295 == 0, 301);
        InstrumentSpec{
            product    : 0,
            underlying : ((arg0 >> 224) as u32),
            expiry_ms  : v0 * 1000,
            lot_payout : 1,
            collateral : arg1,
            terms      : b"",
        }
    }

    public fun has_position(arg0: &Instrument, arg1: address) : bool {
        0x2::table::contains<address, Position>(&arg0.positions, arg1)
    }

    public fun id_of(arg0: &InstrumentSpec) : u256 {
        let v0 = 0x2::bcs::to_bytes<InstrumentSpec>(arg0);
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 32) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v1, v3) as u256);
            v3 = v3 + 1;
        };
        v2 & 452312848583266388373324160190187140051835877600158453279131187530910662655 | 115339776388732929035197660848497720713218148788040405586178452820382218977280
    }

    public fun is_closed(arg0: &Instrument) : bool {
        0x1::option::is_some<u64>(&arg0.payout_per_lot) || 0x1::option::is_some<Refund>(&arg0.refund)
    }

    public fun is_grid(arg0: &InstrumentSpec) : bool {
        arg0.product == 0
    }

    public fun is_refunding(arg0: &Instrument) : bool {
        0x1::option::is_some<Refund>(&arg0.refund)
    }

    public fun is_settled(arg0: &Instrument) : bool {
        0x1::option::is_some<u64>(&arg0.payout_per_lot)
    }

    public fun long_basis(arg0: &Instrument) : u128 {
        arg0.long_basis
    }

    public fun long_of(arg0: &Instrument, arg1: address) : u64 {
        let (v0, v1) = position(arg0, arg1);
        if (v1) {
            0
        } else {
            v0
        }
    }

    public fun lot_payout(arg0: &InstrumentSpec) : u64 {
        arg0.lot_payout
    }

    public fun lots_value(arg0: &InstrumentSpec, arg1: u64) : u64 {
        let v0 = (arg0.lot_payout as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 307);
        (v0 as u64)
    }

    public fun open_interest(arg0: &Instrument) : u64 {
        arg0.open_interest
    }

    fun part(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun payout_per_lot(arg0: &Instrument) : 0x1::option::Option<u64> {
        arg0.payout_per_lot
    }

    public fun position(arg0: &Instrument, arg1: address) : (u64, bool) {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return (0, false)
        };
        let v0 = 0x2::table::borrow<address, Position>(&arg0.positions, arg1);
        (v0.amount, v0.is_short)
    }

    public fun position_count(arg0: &Instrument) : u64 {
        0x2::table::length<address, Position>(&arg0.positions)
    }

    public fun product(arg0: &InstrumentSpec) : u8 {
        arg0.product
    }

    fun put_on(arg0: &mut Instrument, arg1: address, arg2: bool, arg3: u64, arg4: u64) {
        if (arg3 == 0) {
            return
        };
        if (0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, arg1);
            v0.amount = v0.amount + arg3;
            v0.basis = v0.basis + arg4;
        } else {
            let v1 = Position{
                amount   : arg3,
                is_short : arg2,
                basis    : arg4,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, arg1, v1);
        };
        add_basis(arg0, arg2, arg4);
    }

    fun refund_claim(arg0: u64, arg1: bool, arg2: &Position) : u128 {
        if (arg2.is_short) {
            let v1 = (arg0 as u128) * (arg2.amount as u128);
            if (arg1) {
                v1 - 0x1::u128::min((arg2.basis as u128), v1)
            } else {
                v1
            }
        } else if (arg1) {
            (arg2.basis as u128)
        } else {
            0
        }
    }

    public(friend) fun settle(arg0: &mut Instrument, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x1::option::is_none<Refund>(&arg0.refund), 308);
        assert!(0x1::option::is_none<u64>(&arg0.payout_per_lot), 302);
        assert!(arg1 <= arg0.spec.lot_payout, 303);
        arg0.payout_per_lot = 0x1::option::some<u64>(arg1);
        arg0.settled_at_ms = arg2;
        arg0.claims_open_ms = arg3;
    }

    public fun settled_at_ms(arg0: &Instrument) : u64 {
        arg0.settled_at_ms
    }

    public fun settled_claims(arg0: &Instrument) : u64 {
        arg0.settled_claims
    }

    public fun short_basis(arg0: &Instrument) : u128 {
        arg0.short_basis
    }

    public fun short_lots(arg0: &Instrument) : u64 {
        arg0.short_lots
    }

    public fun short_of(arg0: &Instrument, arg1: address) : u64 {
        let (v0, v1) = position(arg0, arg1);
        if (v1) {
            v0
        } else {
            0
        }
    }

    public fun spec(arg0: u8, arg1: u32, arg2: u64, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: vector<u8>) : InstrumentSpec {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 300);
        assert!(arg3 > 0, 301);
        InstrumentSpec{
            product    : arg0,
            underlying : arg1,
            expiry_ms  : arg2,
            lot_payout : arg3,
            collateral : arg4,
            terms      : arg5,
        }
    }

    public fun spec_of(arg0: &Instrument) : &InstrumentSpec {
        &arg0.spec
    }

    fun sub_basis(arg0: &mut Instrument, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.short_basis = arg0.short_basis - 0x1::u128::min((arg2 as u128), arg0.short_basis);
        } else {
            arg0.long_basis = arg0.long_basis - 0x1::u128::min((arg2 as u128), arg0.long_basis);
        };
    }

    public(friend) fun sweep(arg0: &mut Instrument) : u64 {
        assert!(0x1::option::is_some<Refund>(&arg0.refund), 305);
        arg0.collateral = 0;
        arg0.collateral
    }

    public(friend) fun take_claim(arg0: &mut Instrument, arg1: address) : (u64, bool, u64) {
        assert!(0x1::option::is_some<u64>(&arg0.payout_per_lot) || 0x1::option::is_some<Refund>(&arg0.refund), 305);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, arg1), 304);
        let v0 = 0x2::table::remove<address, Position>(&mut arg0.positions, arg1);
        let v1 = if (0x1::option::is_some<Refund>(&arg0.refund)) {
            let v2 = *0x1::option::borrow<Refund>(&arg0.refund);
            let v3 = refund_claim(arg0.spec.lot_payout, v2.pays_basis, &v0);
            if (v2.total == 0) {
                0
            } else {
                0x1::u128::min(v3 * (v2.pool as u128) / v2.total, v3)
            }
        } else {
            let v4 = if (v0.is_short) {
                arg0.spec.lot_payout - *0x1::option::borrow<u64>(&arg0.payout_per_lot)
            } else {
                *0x1::option::borrow<u64>(&arg0.payout_per_lot)
            };
            arg0.settled_claims = arg0.settled_claims + 1;
            (v4 as u128) * (v0.amount as u128)
        };
        let v5 = (0x1::u128::min(v1, (arg0.collateral as u128)) as u64);
        arg0.collateral = arg0.collateral - v5;
        let Position {
            amount   : v6,
            is_short : v7,
            basis    : v8,
        } = v0;
        sub_basis(arg0, v7, v8);
        if (v7) {
            arg0.short_lots = arg0.short_lots - 0x1::u64::min(v6, arg0.short_lots);
        } else {
            arg0.open_interest = arg0.open_interest - 0x1::u64::min(v6, arg0.open_interest);
        };
        (v6, v7, v5)
    }

    fun take_off(arg0: &mut Instrument, arg1: address, arg2: bool, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, arg1);
        let v1 = part(v0.basis, arg3, v0.amount);
        v0.amount = v0.amount - arg3;
        v0.basis = v0.basis - v1;
        if (v0.amount == 0) {
            0x2::table::remove<address, Position>(&mut arg0.positions, arg1);
        };
        sub_basis(arg0, arg2, v1);
        v1
    }

    public fun terms(arg0: &InstrumentSpec) : &vector<u8> {
        &arg0.terms
    }

    public fun underlying(arg0: &InstrumentSpec) : u32 {
        arg0.underlying
    }

    // decompiled from Move bytecode v7
}

