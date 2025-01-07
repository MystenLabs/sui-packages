module 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::state {
    struct StateCreated has copy, drop {
        state: 0x2::object::ID,
    }

    struct LockedFunds<phantom T0> has store, key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
    }

    struct SourceOrder has store {
        status: u8,
        locked_funds: 0x2::object::ID,
        chain_dest: u16,
        trader: address,
        token_in: address,
        fee_cancel: u64,
        fee_refund: u64,
    }

    struct EmitterPaired has store {
        auction: address,
        evm: address,
        solana: address,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        paused: bool,
        emitter_paired: EmitterPaired,
        source_order_registry: 0x2::table::Table<address, SourceOrder>,
        dest_order_registry: 0x2::table::Table<address, SourceOrder>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : State {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::sequence(&arg0) == 0, 0);
        let v0 = EmitterPaired{
            auction : arg3,
            evm     : arg1,
            solana  : arg2,
        };
        let v1 = State{
            id                    : 0x2::object::new(arg4),
            emitter_cap           : arg0,
            paused                : false,
            emitter_paired        : v0,
            source_order_registry : 0x2::table::new<address, SourceOrder>(arg4),
            dest_order_registry   : 0x2::table::new<address, SourceOrder>(arg4),
        };
        let v2 = StateCreated{state: 0x2::object::id<State>(&v1)};
        0x2::event::emit<StateCreated>(v2);
        v1
    }

    public(friend) fun add_source_order<T0>(arg0: &mut State, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: address, arg4: address, arg5: u16, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::object::ID) {
        let v0 = LockedFunds<T0>{
            id    : 0x2::object::new(arg8),
            funds : arg1,
        };
        let v1 = 0x2::object::id<LockedFunds<T0>>(&v0);
        let v2 = SourceOrder{
            status       : 1,
            locked_funds : v1,
            chain_dest   : arg5,
            trader       : arg3,
            token_in     : arg4,
            fee_cancel   : arg6,
            fee_refund   : arg7,
        };
        0x2::table::add<address, SourceOrder>(&mut arg0.source_order_registry, arg2, v2);
        0x2::transfer::share_object<LockedFunds<T0>>(v0);
        (0x2::balance::value<T0>(&arg1), v1)
    }

    entry fun change_paused(arg0: &AdminCap, arg1: &mut State, arg2: bool) {
        arg1.paused = arg2;
    }

    public(friend) fun get_auction_emitter(arg0: &State) : address {
        arg0.emitter_paired.auction
    }

    public(friend) fun get_evm_emitter(arg0: &State) : address {
        arg0.emitter_paired.evm
    }

    public(friend) fun get_solana_emitter(arg0: &State) : address {
        arg0.emitter_paired.solana
    }

    public(friend) fun get_source_order_locked_funds_id(arg0: &State, arg1: address) : 0x2::object::ID {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).locked_funds
    }

    public(friend) fun get_source_order_status(arg0: &State, arg1: address) : u8 {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).status
    }

    public(friend) fun get_source_order_token_in(arg0: &State, arg1: address) : address {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).token_in
    }

    public(friend) fun get_source_order_trader(arg0: &State, arg1: address) : address {
        0x2::table::borrow<address, SourceOrder>(&arg0.source_order_registry, arg1).trader
    }

    public(friend) fun get_sui_emitter(arg0: &State) : address {
        let v0 = 0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&arg0.emitter_cap);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun has_dest_order(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, SourceOrder>(&arg0.source_order_registry, arg1)
    }

    public(friend) fun has_order(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, SourceOrder>(&arg0.source_order_registry, arg1) || 0x2::table::contains<address, SourceOrder>(&arg0.dest_order_registry, arg1)
    }

    public(friend) fun has_source_order(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, SourceOrder>(&arg0.source_order_registry, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_paused(arg0: &State) : bool {
        arg0.paused
    }

    public(friend) fun refund_source_order<T0>(arg0: &mut State, arg1: LockedFunds<T0>, arg2: address, arg3: address, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::table::borrow_mut<address, SourceOrder>(&mut arg0.source_order_registry, arg2);
        v0.status = 3;
        let LockedFunds {
            id    : v1,
            funds : v2,
        } = arg1;
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::amount::denormalize_amount(v0.fee_cancel, arg4)), arg5), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v3), arg5), v0.trader);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::amount::denormalize_amount(v0.fee_refund, arg4)), arg5)
    }

    public(friend) fun source_order_status_created() : u8 {
        1
    }

    public(friend) fun source_order_status_refunded() : u8 {
        3
    }

    public(friend) fun source_order_status_unlocked() : u8 {
        2
    }

    public(friend) fun unlock_source_order<T0>(arg0: &mut State, arg1: LockedFunds<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<address, SourceOrder>(&mut arg0.source_order_registry, arg2).status = 2;
        let LockedFunds {
            id    : v0,
            funds : v1,
        } = arg1;
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v2), arg4), arg3);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public(friend) fun verify_auction_emitter(arg0: &State, arg1: address, arg2: u16) {
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg1 == arg0.emitter_paired.auction, 1);
        assert!(arg2 == 1, 1);
    }

    public(friend) fun verify_swift_emitter(arg0: &State, arg1: address, arg2: u16) {
        assert!(arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        if (arg2 == 1) {
            assert!(arg1 == arg0.emitter_paired.solana, 1);
        } else {
            assert!(arg1 == arg0.emitter_paired.evm, 1);
        };
    }

    // decompiled from Move bytecode v6
}

