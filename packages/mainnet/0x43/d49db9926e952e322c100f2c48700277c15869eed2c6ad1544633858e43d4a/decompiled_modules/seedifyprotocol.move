module 0x43d49db9926e952e322c100f2c48700277c15869eed2c6ad1544633858e43d4a::seedifyprotocol {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        immediate_transfer_balance: 0x2::balance::Balance<T0>,
        start: u64,
        released: u64,
        duration: u64,
        claim_interval: u64,
        last_claimed: u64,
        renouncement_start: u64,
        renouncement_end: u64,
        claim_renounced: bool,
        immediate_transfer_claimed: bool,
        immediate_claim_start: u64,
        is_claiming_paused: bool,
    }

    struct GlobalPauseState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
        admin_address: address,
    }

    struct TransferAdminCapEvent has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin_address: address,
    }

    public fun balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Wallet<T0>) {
        let Wallet {
            id                         : v0,
            balance                    : v1,
            immediate_transfer_balance : v2,
            start                      : _,
            released                   : _,
            duration                   : _,
            claim_interval             : _,
            last_claimed               : _,
            renouncement_start         : _,
            renouncement_end           : _,
            claim_renounced            : _,
            immediate_transfer_claimed : _,
            immediate_claim_start      : _,
            is_claiming_paused         : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(v2);
    }

    public fun new<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Wallet<T0> {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg4), 0);
        assert!(0x2::coin::value<T0>(arg0) >= arg1 + arg2, 2);
        assert!(arg7 <= arg6, 9);
        assert!(arg8 <= arg9, 10);
        Wallet<T0>{
            id                         : 0x2::object::new(arg10),
            balance                    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg10)),
            immediate_transfer_balance : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg2, arg10)),
            start                      : arg5,
            released                   : 0,
            duration                   : arg6,
            claim_interval             : arg7,
            last_claimed               : arg5,
            renouncement_start         : arg8,
            renouncement_end           : arg9,
            claim_renounced            : false,
            immediate_transfer_claimed : false,
            immediate_claim_start      : arg3,
            is_claiming_paused         : false,
        }
    }

    public fun claim<T0>(arg0: &mut Wallet<T0>, arg1: &GlobalPauseState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg1.is_paused, 8);
        assert!(!arg0.claim_renounced, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_claimed + arg0.claim_interval, 1);
        let v1 = vesting_status<T0>(arg0, arg2);
        assert!(v1 > 0, 2);
        arg0.released = arg0.released + v1;
        arg0.last_claimed = v0;
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg3);
        assert!(0x2::coin::value<T0>(&v2) == v1, 2);
        v2
    }

    entry fun claim_immediate_transfer<T0>(arg0: &mut Wallet<T0>, arg1: &GlobalPauseState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 8);
        assert!(!arg0.immediate_transfer_claimed, 4);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.immediate_claim_start, 1);
        arg0.immediate_transfer_claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.immediate_transfer_balance, 0x2::balance::value<T0>(&arg0.immediate_transfer_balance)), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun claim_interval<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.claim_interval
    }

    public fun duration<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.duration
    }

    entry fun entry_claim<T0>(arg0: &mut Wallet<T0>, arg1: &GlobalPauseState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    entry fun entry_destroy_zero<T0>(arg0: Wallet<T0>) {
        destroy_zero<T0>(arg0);
    }

    entry fun entry_new<T0>(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == arg0.admin_address, 7);
        assert!(arg3 <= 100, 3);
        let v0 = arg2 * arg3 / 100;
        0x2::transfer::public_transfer<Wallet<T0>>(new<T0>(arg1, arg2 - v0, v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12), arg11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id            : 0x2::object::new(arg0),
            admin_address : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalPauseState{
            id        : 0x2::object::new(arg0),
            is_paused : false,
        };
        0x2::transfer::share_object<GlobalPauseState>(v1);
    }

    public fun is_claim_renounced<T0>(arg0: &Wallet<T0>) : bool {
        arg0.claim_renounced
    }

    public fun last_claimed<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.last_claimed
    }

    fun linear_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        linear_vesting_schedule(arg0, arg1, arg2 + arg3, arg4)
    }

    fun linear_vesting_schedule(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg0) {
            0
        } else if (arg3 >= arg0 + arg1) {
            arg2
        } else {
            arg2 * (arg3 - arg0) / arg1
        }
    }

    public fun new_admin(arg0: &mut 0x2::tx_context::TxContext) : Admin {
        Admin{
            id            : 0x2::object::new(arg0),
            admin_address : 0x2::tx_context::sender(arg0),
        }
    }

    public entry fun pause_contract(arg0: &AdminCap, arg1: &mut GlobalPauseState, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 7);
        arg1.is_paused = true;
    }

    public fun released<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.released
    }

    entry fun renounce_claim<T0>(arg0: Wallet<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.renouncement_start, 100);
        assert!(v0 <= arg0.renouncement_end, 101);
        assert!(v0 >= arg0.renouncement_start && v0 <= arg0.renouncement_end, 6);
        assert!(arg0.released == 0 && !arg0.immediate_transfer_claimed, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg3), arg1.admin_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.immediate_transfer_balance, 0x2::balance::value<T0>(&arg0.immediate_transfer_balance)), arg3), arg1.admin_address);
        destroy_zero<T0>(arg0);
    }

    public fun start<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.start
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        arg0.admin_address = arg1;
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
        let v0 = TransferAdminCapEvent{
            previous_owner : 0x2::tx_context::sender(arg2),
            new_owner      : arg1,
        };
        0x2::event::emit<TransferAdminCapEvent>(v0);
    }

    public entry fun unpause_contract(arg0: &AdminCap, arg1: &mut GlobalPauseState, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 7);
        arg1.is_paused = false;
    }

    public fun vesting_status<T0>(arg0: &Wallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        assert!(!arg0.claim_renounced, 5);
        linear_vested_amount(arg0.start, arg0.duration, 0x2::balance::value<T0>(&arg0.balance), arg0.released, 0x2::clock::timestamp_ms(arg1)) - arg0.released
    }

    // decompiled from Move bytecode v6
}

