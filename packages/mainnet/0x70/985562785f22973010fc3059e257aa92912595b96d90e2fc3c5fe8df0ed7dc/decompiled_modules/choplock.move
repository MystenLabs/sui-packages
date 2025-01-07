module 0x70985562785f22973010fc3059e257aa92912595b96d90e2fc3c5fe8df0ed7dc::choplock {
    struct LockedTokens<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        tokens: 0x2::balance::Balance<T0>,
        locked_until_epoch: u64,
        last_updated: u64,
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg1, 0);
        let v0 = LockedTokens<T0>{
            id                 : 0x2::object::new(arg3),
            owner              : 0x2::tx_context::sender(arg3),
            tokens             : 0x2::coin::into_balance<T0>(arg0),
            locked_until_epoch : arg1,
            last_updated       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::share_object<LockedTokens<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut LockedTokens<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg1));
        arg0.last_updated = 0x2::clock::timestamp_ms(arg2);
    }

    public fun locked_balance<T0>(arg0: &LockedTokens<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun locked_until_epoch<T0>(arg0: &LockedTokens<T0>) : u64 {
        arg0.locked_until_epoch
    }

    public fun owner<T0>(arg0: &LockedTokens<T0>) : address {
        arg0.owner
    }

    public fun unlock<T0>(arg0: LockedTokens<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.locked_until_epoch, 1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        let LockedTokens {
            id                 : v0,
            owner              : v1,
            tokens             : v2,
            locked_until_epoch : _,
            last_updated       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), v1);
    }

    // decompiled from Move bytecode v6
}

