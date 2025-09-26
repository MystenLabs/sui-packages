module 0x80295ce403737116524f0e048278c7ba022bc397a97139fc692a2d81f5bf1199::htlc {
    struct Swap<phantom T0> has key {
        id: 0x2::object::UID,
        maker: address,
        taker: address,
        amount: 0x2::balance::Balance<T0>,
        hash_lock: vector<u8>,
        timelock: u64,
        withdrawn: bool,
        refunded: bool,
    }

    struct SwapCreated<phantom T0> has copy, drop {
        swap_id: address,
        maker: address,
        taker: address,
        amount: u64,
        hash_lock: vector<u8>,
        timelock: u64,
    }

    struct SwapWithdrawn has copy, drop {
        swap_id: address,
    }

    struct SwapRefunded has copy, drop {
        swap_id: address,
    }

    public fun create_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 4);
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = Swap<T0>{
            id        : 0x2::object::new(arg5),
            maker     : 0x2::tx_context::sender(arg5),
            taker     : arg1,
            amount    : v0,
            hash_lock : arg2,
            timelock  : arg3,
            withdrawn : false,
            refunded  : false,
        };
        let v2 = SwapCreated<T0>{
            swap_id   : 0x2::object::uid_to_address(&v1.id),
            maker     : 0x2::tx_context::sender(arg5),
            taker     : arg1,
            amount    : 0x2::balance::value<T0>(&v0),
            hash_lock : arg2,
            timelock  : arg3,
        };
        0x2::event::emit<SwapCreated<T0>>(v2);
        0x2::transfer::share_object<Swap<T0>>(v1);
    }

    public fun create_swap_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        create_swap<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun get_amount<T0>(arg0: &Swap<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.amount)
    }

    public fun get_maker<T0>(arg0: &Swap<T0>) : address {
        arg0.maker
    }

    public fun get_taker<T0>(arg0: &Swap<T0>) : address {
        arg0.taker
    }

    public fun get_timelock<T0>(arg0: &Swap<T0>) : u64 {
        arg0.timelock
    }

    public fun is_refunded<T0>(arg0: &Swap<T0>) : bool {
        arg0.refunded
    }

    public fun is_withdrawn<T0>(arg0: &Swap<T0>) : bool {
        arg0.withdrawn
    }

    public fun refund<T0>(arg0: &mut Swap<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 5);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.timelock, 3);
        assert!(!arg0.withdrawn, 1);
        assert!(!arg0.refunded, 2);
        arg0.refunded = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.amount, 0x2::balance::value<T0>(&arg0.amount)), arg2), arg0.maker);
        let v0 = SwapRefunded{swap_id: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<SwapRefunded>(v0);
    }

    public fun refund_entry<T0>(arg0: &mut Swap<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        refund<T0>(arg0, arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Swap<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.timelock, 4);
        assert!(!arg0.withdrawn, 1);
        assert!(!arg0.refunded, 2);
        assert!(0x2::hash::keccak256(&arg1) == arg0.hash_lock, 0);
        arg0.withdrawn = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.amount, 0x2::balance::value<T0>(&arg0.amount)), arg3), arg0.taker);
        let v0 = SwapWithdrawn{swap_id: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<SwapWithdrawn>(v0);
    }

    public fun withdraw_entry<T0>(arg0: &mut Swap<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        withdraw<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

