module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle {
    struct IndexProof has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        underlying: u32,
        price: u64,
        at_ms: u64,
    }

    struct MarkProof has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        instrument: u256,
        price_per_million_lots: u128,
        at_ms: u64,
    }

    struct SettleProof has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        instrument: u256,
        payout_per_lot: u64,
        at_ms: u64,
    }

    struct RiskApproval has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        user: address,
        seq: u64,
        instrument: u256,
        is_buy: bool,
        is_maker: bool,
        nonce: u64,
        amount: u64,
        total_price: u64,
        debt_after: u64,
        at_ms: u64,
    }

    struct WithdrawApproval has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        user: address,
        seq: u64,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        at_ms: u64,
    }

    struct LiquidationLeg has copy, drop, store {
        instrument: u256,
        amount: u64,
        is_short: bool,
        total_price: u64,
    }

    struct CoinLeg has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        amount: u64,
        total_price: u64,
    }

    struct Liquidation has copy, drop {
        domain: vector<u8>,
        exchange: 0x2::object::ID,
        user: address,
        seq: u64,
        take: vector<LiquidationLeg>,
        coins: vector<CoinLeg>,
        write_off: bool,
        at_ms: u64,
    }

    public fun cancel_domain() : vector<u8> {
        b"paramx-core-v1::CancelIntent"
    }

    public(friend) fun check_fresh(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1 + 5000 && arg1 <= arg0 + 60000, 101);
    }

    public(friend) fun check_index_price(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 1000000000000000000, 105);
    }

    public(friend) fun check_market_fresh(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1 + 5000 && arg1 <= arg0 + 30000, 101);
    }

    public(friend) fun check_settle_fresh(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1 + 5000 && arg1 <= arg0 + 86400000, 101);
    }

    public(friend) fun check_target(arg0: &vector<u8>, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(*arg0 == arg1, 103);
        assert!(arg2 == arg3, 102);
    }

    public fun coin_leg(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64) : CoinLeg {
        CoinLeg{
            coin        : arg0,
            amount      : arg1,
            total_price : arg2,
        }
    }

    public fun coin_leg_amount(arg0: &CoinLeg) : u64 {
        arg0.amount
    }

    public fun coin_leg_coin(arg0: &CoinLeg) : 0x1::type_name::TypeName {
        arg0.coin
    }

    public fun coin_leg_total_price(arg0: &CoinLeg) : u64 {
        arg0.total_price
    }

    public fun index_at_ms(arg0: &IndexProof) : u64 {
        arg0.at_ms
    }

    public fun index_domain() : vector<u8> {
        b"paramx-core-v1::IndexProof"
    }

    public fun index_domain_of(arg0: &IndexProof) : &vector<u8> {
        &arg0.domain
    }

    public fun index_exchange(arg0: &IndexProof) : 0x2::object::ID {
        arg0.exchange
    }

    public fun index_price(arg0: &IndexProof) : u64 {
        arg0.price
    }

    public fun index_proof(arg0: 0x2::object::ID, arg1: u32, arg2: u64, arg3: u64) : IndexProof {
        IndexProof{
            domain     : index_domain(),
            exchange   : arg0,
            underlying : arg1,
            price      : arg2,
            at_ms      : arg3,
        }
    }

    public fun index_underlying(arg0: &IndexProof) : u32 {
        arg0.underlying
    }

    public fun is_small_order(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 32) {
            return true
        };
        let v0 = *arg0;
        *0x1::vector::borrow_mut<u8>(&mut v0, 31) = *0x1::vector::borrow<u8>(&v0, 31) & 127;
        let v1 = vector[x"0000000000000000000000000000000000000000000000000000000000000000", x"0100000000000000000000000000000000000000000000000000000000000000", x"26e8958fc2b227b045c3f489f2ef98f0d5dfac05d3c63339b13802886d53fc05", x"c7176a703d4dd84fba3c0b760d10670f2a2053fa2c39ccc64ec7fd7792ac037a", x"ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"];
        0x1::vector::contains<vector<u8>>(&v1, &v0)
    }

    public fun leg_amount(arg0: &LiquidationLeg) : u64 {
        arg0.amount
    }

    public fun leg_instrument(arg0: &LiquidationLeg) : u256 {
        arg0.instrument
    }

    public fun leg_is_short(arg0: &LiquidationLeg) : bool {
        arg0.is_short
    }

    public fun leg_total_price(arg0: &LiquidationLeg) : u64 {
        arg0.total_price
    }

    public fun liquidation(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<LiquidationLeg>, arg4: vector<CoinLeg>, arg5: bool, arg6: u64) : Liquidation {
        Liquidation{
            domain    : liquidation_domain(),
            exchange  : arg0,
            user      : arg1,
            seq       : arg2,
            take      : arg3,
            coins     : arg4,
            write_off : arg5,
            at_ms     : arg6,
        }
    }

    public fun liquidation_at_ms(arg0: &Liquidation) : u64 {
        arg0.at_ms
    }

    public fun liquidation_coins(arg0: &Liquidation) : &vector<CoinLeg> {
        &arg0.coins
    }

    public fun liquidation_domain() : vector<u8> {
        b"paramx-core-v1::Liquidation"
    }

    public fun liquidation_domain_of(arg0: &Liquidation) : &vector<u8> {
        &arg0.domain
    }

    public fun liquidation_exchange(arg0: &Liquidation) : 0x2::object::ID {
        arg0.exchange
    }

    public fun liquidation_leg(arg0: u256, arg1: u64, arg2: bool, arg3: u64) : LiquidationLeg {
        LiquidationLeg{
            instrument  : arg0,
            amount      : arg1,
            is_short    : arg2,
            total_price : arg3,
        }
    }

    public fun liquidation_seq(arg0: &Liquidation) : u64 {
        arg0.seq
    }

    public fun liquidation_take(arg0: &Liquidation) : &vector<LiquidationLeg> {
        &arg0.take
    }

    public fun liquidation_user(arg0: &Liquidation) : address {
        arg0.user
    }

    public fun liquidation_write_off(arg0: &Liquidation) : bool {
        arg0.write_off
    }

    public fun mark_at_ms(arg0: &MarkProof) : u64 {
        arg0.at_ms
    }

    public fun mark_domain() : vector<u8> {
        b"paramx-core-v1::MarkProof"
    }

    public fun mark_domain_of(arg0: &MarkProof) : &vector<u8> {
        &arg0.domain
    }

    public fun mark_exchange(arg0: &MarkProof) : 0x2::object::ID {
        arg0.exchange
    }

    public fun mark_instrument(arg0: &MarkProof) : u256 {
        arg0.instrument
    }

    public fun mark_price_per_million_lots(arg0: &MarkProof) : u128 {
        arg0.price_per_million_lots
    }

    public fun mark_proof(arg0: 0x2::object::ID, arg1: u256, arg2: u128, arg3: u64) : MarkProof {
        MarkProof{
            domain                 : mark_domain(),
            exchange               : arg0,
            instrument             : arg1,
            price_per_million_lots : arg2,
            at_ms                  : arg3,
        }
    }

    public fun mark_value(arg0: &MarkProof, arg1: u64) : u128 {
        arg0.price_per_million_lots * (arg1 as u128) / 1000000
    }

    public fun order_domain() : vector<u8> {
        b"paramx-core-v1::OrderIntent"
    }

    public fun risk_amount(arg0: &RiskApproval) : u64 {
        arg0.amount
    }

    public fun risk_approval(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u256, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : RiskApproval {
        RiskApproval{
            domain      : risk_domain(),
            exchange    : arg0,
            user        : arg1,
            seq         : arg2,
            instrument  : arg3,
            is_buy      : arg4,
            is_maker    : arg5,
            nonce       : arg6,
            amount      : arg7,
            total_price : arg8,
            debt_after  : arg9,
            at_ms       : arg10,
        }
    }

    public fun risk_at_ms(arg0: &RiskApproval) : u64 {
        arg0.at_ms
    }

    public fun risk_debt_after(arg0: &RiskApproval) : u64 {
        arg0.debt_after
    }

    public fun risk_domain() : vector<u8> {
        b"paramx-core-v1::RiskApproval"
    }

    public fun risk_domain_of(arg0: &RiskApproval) : &vector<u8> {
        &arg0.domain
    }

    public fun risk_exchange(arg0: &RiskApproval) : 0x2::object::ID {
        arg0.exchange
    }

    public fun risk_instrument(arg0: &RiskApproval) : u256 {
        arg0.instrument
    }

    public fun risk_is_buy(arg0: &RiskApproval) : bool {
        arg0.is_buy
    }

    public fun risk_is_maker(arg0: &RiskApproval) : bool {
        arg0.is_maker
    }

    public fun risk_nonce(arg0: &RiskApproval) : u64 {
        arg0.nonce
    }

    public fun risk_seq(arg0: &RiskApproval) : u64 {
        arg0.seq
    }

    public fun risk_total_price(arg0: &RiskApproval) : u64 {
        arg0.total_price
    }

    public fun risk_user(arg0: &RiskApproval) : address {
        arg0.user
    }

    public fun settle_at_ms(arg0: &SettleProof) : u64 {
        arg0.at_ms
    }

    public fun settle_domain() : vector<u8> {
        b"paramx-core-v1::SettleProof"
    }

    public fun settle_domain_of(arg0: &SettleProof) : &vector<u8> {
        &arg0.domain
    }

    public fun settle_exchange(arg0: &SettleProof) : 0x2::object::ID {
        arg0.exchange
    }

    public fun settle_instrument(arg0: &SettleProof) : u256 {
        arg0.instrument
    }

    public fun settle_payout(arg0: &SettleProof) : u64 {
        arg0.payout_per_lot
    }

    public fun settle_proof(arg0: 0x2::object::ID, arg1: u256, arg2: u64, arg3: u64) : SettleProof {
        SettleProof{
            domain         : settle_domain(),
            exchange       : arg0,
            instrument     : arg1,
            payout_per_lot : arg2,
            at_ms          : arg3,
        }
    }

    public(friend) fun verify<T0: drop>(arg0: &vector<u8>, arg1: &T0, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 104);
        let v0 = 0x2::bcs::to_bytes<T0>(arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, arg0, &v0), 100);
    }

    public fun withdraw_amount(arg0: &WithdrawApproval) : u64 {
        arg0.amount
    }

    public fun withdraw_approval(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64) : WithdrawApproval {
        WithdrawApproval{
            domain   : withdraw_domain(),
            exchange : arg0,
            user     : arg1,
            seq      : arg2,
            coin     : arg3,
            amount   : arg4,
            at_ms    : arg5,
        }
    }

    public fun withdraw_at_ms(arg0: &WithdrawApproval) : u64 {
        arg0.at_ms
    }

    public fun withdraw_coin(arg0: &WithdrawApproval) : 0x1::type_name::TypeName {
        arg0.coin
    }

    public fun withdraw_domain() : vector<u8> {
        b"paramx-core-v1::WithdrawApproval"
    }

    public fun withdraw_domain_of(arg0: &WithdrawApproval) : &vector<u8> {
        &arg0.domain
    }

    public fun withdraw_exchange(arg0: &WithdrawApproval) : 0x2::object::ID {
        arg0.exchange
    }

    public fun withdraw_seq(arg0: &WithdrawApproval) : u64 {
        arg0.seq
    }

    public fun withdraw_user(arg0: &WithdrawApproval) : address {
        arg0.user
    }

    // decompiled from Move bytecode v7
}

