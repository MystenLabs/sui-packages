module 0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::lattice {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LatticeEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        intents: 0x2::table::Table<u64, Intent>,
        intent_counter: u64,
        coin_balance: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        accumulated_fees: 0x2::balance::Balance<T0>,
        paused: bool,
    }

    struct Intent has store {
        status: u8,
        user_sui_address: address,
        user_solana_address: vector<u8>,
        input_amount: u64,
        output_token_mint: vector<u8>,
        min_output_amount: u64,
        deadline: u64,
        created_at: u64,
        fulfillment_tx: vector<u8>,
        actual_output: u64,
    }

    struct LATTICE has drop {
        dummy_field: bool,
    }

    public fun accumulated_fees<T0>(arg0: &LatticeEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.accumulated_fees)
    }

    public fun admin_cancel_intent<T0>(arg0: &mut LatticeEscrow<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Intent>(&arg0.intents, arg2), 6);
        let v0 = 0x2::table::borrow_mut<u64, Intent>(&mut arg0.intents, arg2);
        assert!(v0.status == 0, 8);
        v0.status = 2;
        let v1 = v0.input_amount;
        let v2 = v0.user_sui_address;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_balance, v1), arg3), v2);
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_intent_cancelled(0x2::object::id<LatticeEscrow<T0>>(arg0), arg2, v2, v1);
    }

    public fun cancel_intent<T0>(arg0: &mut LatticeEscrow<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Intent>(&arg0.intents, arg1), 6);
        let v0 = 0x2::table::borrow_mut<u64, Intent>(&mut arg0.intents, arg1);
        assert!(v0.user_sui_address == 0x2::tx_context::sender(arg3), 7);
        assert!(v0.status == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.deadline, 9);
        v0.status = 2;
        let v1 = v0.input_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_balance, v1), arg3), 0x2::tx_context::sender(arg3));
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_intent_cancelled(0x2::object::id<LatticeEscrow<T0>>(arg0), arg1, 0x2::tx_context::sender(arg3), v1);
    }

    public fun confirm_fulfillment<T0>(arg0: &mut LatticeEscrow<T0>, arg1: &AdminCap, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Intent>(&arg0.intents, arg2), 6);
        assert!(0x1::vector::length<u8>(&arg3) == 64, 13);
        let v0 = 0x2::table::borrow_mut<u64, Intent>(&mut arg0.intents, arg2);
        assert!(v0.status == 0, 8);
        assert!(arg4 >= v0.min_output_amount, 10);
        v0.status = 1;
        v0.fulfillment_tx = arg3;
        v0.actual_output = arg4;
        let v1 = v0.input_amount;
        let v2 = v1 * arg0.fee_bps / 10000;
        let v3 = v1 - v2;
        0x2::balance::join<T0>(&mut arg0.accumulated_fees, 0x2::balance::split<T0>(&mut arg0.coin_balance, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_balance, v3), arg5), 0x2::tx_context::sender(arg5));
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_intent_fulfilled(0x2::object::id<LatticeEscrow<T0>>(arg0), arg2, 0x2::tx_context::sender(arg5), v3, v2, v0.fulfillment_tx, arg4);
    }

    public fun create_escrow<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LatticeEscrow<T0>{
            id               : 0x2::object::new(arg1),
            intents          : 0x2::table::new<u64, Intent>(arg1),
            intent_counter   : 0,
            coin_balance     : 0x2::balance::zero<T0>(),
            fee_bps          : 30,
            accumulated_fees : 0x2::balance::zero<T0>(),
            paused           : false,
        };
        0x2::transfer::share_object<LatticeEscrow<T0>>(v0);
    }

    public fun fee_bps<T0>(arg0: &LatticeEscrow<T0>) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: LATTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun intent_count<T0>(arg0: &LatticeEscrow<T0>) : u64 {
        arg0.intent_counter
    }

    public fun is_paused<T0>(arg0: &LatticeEscrow<T0>) : bool {
        arg0.paused
    }

    public fun set_fee_bps<T0>(arg0: &mut LatticeEscrow<T0>, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 500, 11);
        arg0.fee_bps = arg2;
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_fee_updated(0x2::object::id<LatticeEscrow<T0>>(arg0), arg2);
    }

    public fun set_paused<T0>(arg0: &mut LatticeEscrow<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_pause_updated(0x2::object::id<LatticeEscrow<T0>>(arg0), arg2);
    }

    public fun submit_intent<T0>(arg0: &mut LatticeEscrow<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 75000, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 3);
        assert!(arg5 > 0, 4);
        assert!(arg5 <= 86400000, 5);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = v1 + arg5;
        let v3 = Intent{
            status              : 0,
            user_sui_address    : 0x2::tx_context::sender(arg7),
            user_solana_address : arg3,
            input_amount        : v0,
            output_token_mint   : arg2,
            min_output_amount   : arg4,
            deadline            : v2,
            created_at          : v1,
            fulfillment_tx      : 0x1::vector::empty<u8>(),
            actual_output       : 0,
        };
        0x2::balance::join<T0>(&mut arg0.coin_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.intent_counter = arg0.intent_counter + 1;
        let v4 = arg0.intent_counter;
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_intent_created(0x2::object::id<LatticeEscrow<T0>>(arg0), v4, 0x2::tx_context::sender(arg7), v3.user_solana_address, v0, v3.output_token_mint, arg4, v2);
        0x2::table::add<u64, Intent>(&mut arg0.intents, v4, v3);
        v4
    }

    public fun total_locked<T0>(arg0: &LatticeEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.coin_balance)
    }

    public fun withdraw_fees<T0>(arg0: &mut LatticeEscrow<T0>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.accumulated_fees);
        assert!(v0 > 0, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.accumulated_fees), arg3), arg2);
        0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events::emit_fees_withdrawn(0x2::object::id<LatticeEscrow<T0>>(arg0), arg2, v0);
    }

    // decompiled from Move bytecode v6
}

