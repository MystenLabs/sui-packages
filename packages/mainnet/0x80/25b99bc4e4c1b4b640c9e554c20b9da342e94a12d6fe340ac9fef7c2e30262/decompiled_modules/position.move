module 0xd5f3054404ec9275b50985851a5b515728f131a3bdd9c9a5f738a9326b738d53::position {
    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_long: bool,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        created_ts: u64,
        owner: address,
        market_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
    }

    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
    }

    struct OpenPositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        is_long: bool,
        collateral_coin_type: 0x1::type_name::TypeName,
        loan_coin_type: 0x1::type_name::TypeName,
        owner: address,
        timestamp: u64,
    }

    struct ClosePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        timestamp: u64,
    }

    struct BorrowEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        borrow_amount: u64,
        timestamp: u64,
    }

    struct RepayEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        repay_coin_type: 0x1::type_name::TypeName,
        repay_amount: u64,
        timestamp: u64,
    }

    struct ClaimRewardEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        timestamp: u64,
    }

    public(friend) fun assert_market_match<T0>(arg0: &Position<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.market_id == arg1, 13906834844358410243);
    }

    public(friend) fun assert_position_cap_match<T0>(arg0: &Position<T0>, arg1: &PositionCap) {
        assert!(arg1.position_id == 0x2::object::id<Position<T0>>(arg0), 13906834827178409985);
    }

    public(friend) fun create_position<T0>(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg1: bool, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg5);
        let v1 = Position<T0>{
            id                   : v0,
            is_long              : arg1,
            obligation_owner_cap : arg0,
            created_ts           : 0x2::clock::timestamp_ms(arg4),
            owner                : 0x2::tx_context::sender(arg5),
            market_id            : arg3,
            lending_market_id    : arg2,
        };
        0x2::transfer::public_share_object<Position<T0>>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun destroy_position<T0>(arg0: Position<T0>) {
        let Position {
            id                   : v0,
            is_long              : _,
            obligation_owner_cap : v2,
            created_ts           : _,
            owner                : _,
            market_id            : _,
            lending_market_id    : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v2, @0x0);
    }

    public(friend) fun destroy_position_cap(arg0: PositionCap) {
        let PositionCap {
            id          : v0,
            position_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun emit_borrow_event<T0, T1>(arg0: &Position<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = BorrowEvent{
            position_id   : 0x2::object::id<Position<T0>>(arg0),
            owner         : arg0.owner,
            coin_type     : 0x1::type_name::with_defining_ids<T1>(),
            borrow_amount : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BorrowEvent>(v0);
    }

    public(friend) fun emit_claim_reward_event<T0, T1>(arg0: &Position<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = ClaimRewardEvent{
            position_id      : 0x2::object::id<Position<T0>>(arg0),
            owner            : arg0.owner,
            reward_coin_type : 0x1::type_name::with_defining_ids<T1>(),
            reward_amount    : arg1,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimRewardEvent>(v0);
    }

    public(friend) fun emit_close_position_event<T0>(arg0: &Position<T0>, arg1: &0x2::clock::Clock) {
        let v0 = ClosePositionEvent{
            position_id : 0x2::object::id<Position<T0>>(arg0),
            market_id   : arg0.market_id,
            owner       : arg0.owner,
            timestamp   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public(friend) fun emit_deposit_event<T0, T1>(arg0: &Position<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = DepositEvent{
            position_id    : 0x2::object::id<Position<T0>>(arg0),
            owner          : arg0.owner,
            coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            deposit_amount : arg1,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_open_position_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: bool, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: address, arg7: &0x2::clock::Clock) {
        let v0 = OpenPositionEvent{
            position_id          : arg0,
            market_id            : arg1,
            obligation_id        : arg2,
            is_long              : arg3,
            collateral_coin_type : arg4,
            loan_coin_type       : arg5,
            owner                : arg6,
            timestamp            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<OpenPositionEvent>(v0);
    }

    public(friend) fun emit_repay_event<T0, T1>(arg0: &Position<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = RepayEvent{
            position_id     : 0x2::object::id<Position<T0>>(arg0),
            owner           : arg0.owner,
            repay_coin_type : 0x1::type_name::with_defining_ids<T1>(),
            repay_amount    : arg1,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public(friend) fun emit_withdraw_event<T0, T1>(arg0: &Position<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = WithdrawEvent{
            position_id     : 0x2::object::id<Position<T0>>(arg0),
            owner           : arg0.owner,
            coin_type       : 0x1::type_name::with_defining_ids<T1>(),
            withdraw_amount : arg1,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public fun is_long<T0>(arg0: &Position<T0>) : bool {
        arg0.is_long
    }

    public fun lending_market_id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.lending_market_id
    }

    public fun market_id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun new_position_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : PositionCap {
        PositionCap{
            id          : 0x2::object::new(arg1),
            position_id : arg0,
        }
    }

    public fun obligation_id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)
    }

    public(friend) fun obligation_owner_cap<T0>(arg0: &Position<T0>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        &arg0.obligation_owner_cap
    }

    public fun owner<T0>(arg0: &Position<T0>) : address {
        arg0.owner
    }

    public(friend) fun position_id(arg0: &PositionCap) : 0x2::object::ID {
        arg0.position_id
    }

    // decompiled from Move bytecode v7
}

