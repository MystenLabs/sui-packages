module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder {
    struct CollateralHolderKey has copy, drop, store {
        offer_id: 0x1::string::String,
        lend_chain_borrower: 0x1::string::String,
    }

    struct CollateralHolder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        offer_id: 0x1::string::String,
        lend_amount: u64,
        borrower: address,
        collateral: 0x2::balance::Balance<T1>,
        start_timestamp: u64,
        lend_chain: u16,
        status: 0x1::string::String,
    }

    struct CollateralCreatedEvent has copy, drop {
        offer_id: 0x1::string::String,
        lend_chain_id: u16,
        lend_amount: u64,
        collateral_chain_borrower: address,
        collateral_token: 0x1::string::String,
        collateral_amount: u64,
        started_at: u64,
        lend_chain_borrower: 0x1::string::String,
        status: 0x1::string::String,
    }

    struct CollateralHolderCancelledEvent has copy, drop {
        offer_id: 0x1::string::String,
        collateral_chain_borrower: address,
        lend_chain_id: u16,
        collateral_amount: u64,
    }

    struct RefundCollateralHolderEvent has copy, drop {
        offer_id: 0x1::string::String,
        lend_chain_id: u16,
        collateral_chain_borrower: address,
        started_at: u64,
        collateral_amount: u64,
        collateral_token: 0x1::string::String,
    }

    struct DepositCollateralHolderEvent has copy, drop {
        offer_id: 0x1::string::String,
        lend_chain_id: u16,
        collateral_chain_borrower: address,
        collateral_token: 0x1::string::String,
        deposit_amount: u64,
        started_at: u64,
        status: 0x1::string::String,
        collateral_amount: u64,
    }

    struct WithdrawCollateralHolderEvent has copy, drop {
        offer_id: 0x1::string::String,
        lend_chain_id: u16,
        collateral_chain_borrower: address,
        collateral_token: 0x1::string::String,
        withdraw_amount: u64,
        started_at: u64,
        status: 0x1::string::String,
        collateral_amount: u64,
    }

    struct LiquidateCollateralHolderEvent has copy, drop {
        offer_id: 0x1::string::String,
        liquidating_price: u64,
        liquidating_at: u64,
        lend_chain_id: u16,
        collateral_chain_borrower: address,
        started_at: u64,
        collateral_amount: u64,
    }

    public(friend) fun delete<T0, T1>(arg0: CollateralHolder<T0, T1>) : 0x2::balance::Balance<T1> {
        let CollateralHolder {
            id              : v0,
            offer_id        : v1,
            lend_amount     : _,
            borrower        : v3,
            collateral      : v4,
            start_timestamp : _,
            lend_chain      : v6,
            status          : _,
        } = arg0;
        let v8 = v4;
        0x2::object::delete(v0);
        let v9 = CollateralHolderCancelledEvent{
            offer_id                  : v1,
            collateral_chain_borrower : v3,
            lend_chain_id             : v6,
            collateral_amount         : 0x2::balance::value<T1>(&v8),
        };
        0x2::event::emit<CollateralHolderCancelledEvent>(v9);
        v8
    }

    public(friend) fun new<T0, T1>(arg0: 0x1::string::String, arg1: u16, arg2: u64, arg3: address, arg4: 0x2::balance::Balance<T1>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : CollateralHolder<T0, T1> {
        let v0 = CollateralHolder<T0, T1>{
            id              : 0x2::object::new(arg8),
            offer_id        : arg0,
            lend_amount     : arg2,
            borrower        : arg3,
            collateral      : arg4,
            start_timestamp : arg7,
            lend_chain      : arg1,
            status          : 0x1::string::utf8(b"Created"),
        };
        let v1 = CollateralCreatedEvent{
            offer_id                  : arg0,
            lend_chain_id             : arg1,
            lend_amount               : arg2,
            collateral_chain_borrower : arg3,
            collateral_token          : arg5,
            collateral_amount         : 0x2::balance::value<T1>(&arg4),
            started_at                : arg7,
            lend_chain_borrower       : arg6,
            status                    : 0x1::string::utf8(b"Created"),
        };
        0x2::event::emit<CollateralCreatedEvent>(v1);
        v0
    }

    public(friend) fun add_collateral_balance<T0, T1>(arg0: &mut CollateralHolder<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.collateral, arg1);
    }

    public fun borrower<T0, T1>(arg0: &CollateralHolder<T0, T1>) : address {
        arg0.borrower
    }

    public fun collateral_amount<T0, T1>(arg0: &CollateralHolder<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.collateral)
    }

    public(friend) fun deposit_collateral<T0, T1>(arg0: &CollateralHolder<T0, T1>, arg1: u64, arg2: 0x1::string::String) {
        let v0 = DepositCollateralHolderEvent{
            offer_id                  : arg0.offer_id,
            lend_chain_id             : arg0.lend_chain,
            collateral_chain_borrower : arg0.borrower,
            collateral_token          : arg2,
            deposit_amount            : arg1,
            started_at                : arg0.start_timestamp,
            status                    : arg0.status,
            collateral_amount         : 0x2::balance::value<T1>(&arg0.collateral),
        };
        0x2::event::emit<DepositCollateralHolderEvent>(v0);
    }

    public fun holding_collateral_duration() : u64 {
        300
    }

    public fun is_created_status<T0, T1>(arg0: &CollateralHolder<T0, T1>) : bool {
        arg0.status == 0x1::string::utf8(b"Created")
    }

    public fun lend_amount<T0, T1>(arg0: &CollateralHolder<T0, T1>) : u64 {
        arg0.lend_amount
    }

    public fun lend_chain<T0, T1>(arg0: &CollateralHolder<T0, T1>) : u16 {
        arg0.lend_chain
    }

    public(friend) fun liquidate_collateral<T0, T1>(arg0: &mut CollateralHolder<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        arg0.status = 0x1::string::utf8(b"Liquidated");
        let v0 = LiquidateCollateralHolderEvent{
            offer_id                  : arg0.offer_id,
            liquidating_price         : arg1,
            liquidating_at            : arg2,
            lend_chain_id             : arg0.lend_chain,
            collateral_chain_borrower : arg0.borrower,
            started_at                : arg0.start_timestamp,
            collateral_amount         : arg3,
        };
        0x2::event::emit<LiquidateCollateralHolderEvent>(v0);
    }

    public fun new_holder_key(arg0: 0x1::string::String, arg1: 0x1::string::String) : CollateralHolderKey {
        CollateralHolderKey{
            offer_id            : arg0,
            lend_chain_borrower : arg1,
        }
    }

    public(friend) fun refund_collateral_to_repaid_borrower<T0, T1>(arg0: &mut CollateralHolder<T0, T1>, arg1: 0x1::string::String) {
        arg0.status = 0x1::string::utf8(b"BorrowerPaid");
        let v0 = RefundCollateralHolderEvent{
            offer_id                  : arg0.offer_id,
            lend_chain_id             : arg0.lend_chain,
            collateral_chain_borrower : arg0.borrower,
            started_at                : arg0.start_timestamp,
            collateral_amount         : 0x2::balance::value<T1>(&arg0.collateral),
            collateral_token          : arg1,
        };
        0x2::event::emit<RefundCollateralHolderEvent>(v0);
    }

    public fun start_timestamp<T0, T1>(arg0: &CollateralHolder<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    public(friend) fun sub_collateral_balance<T0, T1>(arg0: &mut CollateralHolder<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.collateral, arg1)
    }

    public(friend) fun withdraw_collateral<T0, T1>(arg0: &CollateralHolder<T0, T1>, arg1: u64, arg2: 0x1::string::String) {
        let v0 = WithdrawCollateralHolderEvent{
            offer_id                  : arg0.offer_id,
            lend_chain_id             : arg0.lend_chain,
            collateral_chain_borrower : arg0.borrower,
            collateral_token          : arg2,
            withdraw_amount           : arg1,
            started_at                : arg0.start_timestamp,
            status                    : arg0.status,
            collateral_amount         : 0x2::balance::value<T1>(&arg0.collateral),
        };
        0x2::event::emit<WithdrawCollateralHolderEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

