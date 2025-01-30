module 0x3eb1ec46efb9bce1aea6c8dbd5f2dbddbd68318ff6ab2a4046c60eb23c397ba7::artfivesting {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        released: u64,
        duration: u64,
        claim_interval: u64,
        last_claimed: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Wallet<T0>) {
        let Wallet {
            id             : v0,
            balance        : v1,
            start          : _,
            released       : _,
            duration       : _,
            claim_interval : _,
            last_claimed   : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Wallet<T0> {
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        Wallet<T0>{
            id             : 0x2::object::new(arg6),
            balance        : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg6)),
            start          : arg3,
            released       : 0,
            duration       : arg4,
            claim_interval : arg5,
            last_claimed   : arg3,
        }
    }

    public fun claim<T0>(arg0: &mut Wallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_claimed + arg0.claim_interval, 1);
        let v1 = vesting_status<T0>(arg0, arg1);
        assert!(v1 > 0, 2);
        arg0.released = arg0.released + v1;
        arg0.last_claimed = v0;
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2);
        assert!(0x2::coin::value<T0>(&v2) == v1, 2);
        v2
    }

    public fun claim_interval<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.claim_interval
    }

    public fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        }
    }

    public entry fun create_admin_cap_v2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun duration<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.duration
    }

    public entry fun emergency_migrate_wallet<T0>(arg0: &AdminCap, arg1: Wallet<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 4);
        let Wallet {
            id             : v0,
            balance        : v1,
            start          : v2,
            released       : v3,
            duration       : v4,
            claim_interval : v5,
            last_claimed   : v6,
        } = arg1;
        let v7 = Wallet<T0>{
            id             : 0x2::object::new(arg3),
            balance        : v1,
            start          : v2,
            released       : v3,
            duration       : v4,
            claim_interval : v5,
            last_claimed   : v6,
        };
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Wallet<T0>>(v7, arg2);
    }

    entry fun entry_claim<T0>(arg0: &mut Wallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    entry fun entry_destroy_zero<T0>(arg0: Wallet<T0>) {
        destroy_zero<T0>(arg0);
    }

    entry fun entry_new<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 3);
        let v0 = arg1 * arg2 / 100;
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg8), arg7);
        0x2::transfer::public_transfer<Wallet<T0>>(new<T0>(arg0, arg1 - v0, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public fun is_admin(arg0: &AdminCap, arg1: address) : bool {
        arg0.admin == arg1
    }

    public fun last_claimed<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.last_claimed
    }

    fun linear_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        linear_vesting_schedule(arg0, arg1, arg2 + arg3, arg4)
    }

    fun linear_vesting_schedule(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 > 0, 3);
        if (arg3 <= arg0) {
            return 0
        };
        if (arg3 >= arg0 + arg1) {
            return arg2
        };
        (((arg2 as u128) * ((arg3 - arg0) as u128) / (arg1 as u128)) as u64)
    }

    public entry fun migrate_wallet<T0>(arg0: Wallet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Wallet {
            id             : v0,
            balance        : v1,
            start          : v2,
            released       : v3,
            duration       : v4,
            claim_interval : v5,
            last_claimed   : v6,
        } = arg0;
        let v7 = Wallet<T0>{
            id             : 0x2::object::new(arg1),
            balance        : v1,
            start          : v2,
            released       : v3,
            duration       : v4,
            claim_interval : v5,
            last_claimed   : v6,
        };
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Wallet<T0>>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun released<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.released
    }

    public fun start<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.start
    }

    public fun vesting_status<T0>(arg0: &Wallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        linear_vested_amount(arg0.start, arg0.duration, 0x2::balance::value<T0>(&arg0.balance), arg0.released, 0x2::clock::timestamp_ms(arg1)) - arg0.released
    }

    // decompiled from Move bytecode v6
}

