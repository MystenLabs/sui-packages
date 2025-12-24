module 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>>(0x2::coin::split<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>(&mut arg0.balance, arg1, arg3), arg2);
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::coin::value<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>(&arg0.balance)
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>) {
        0x2::coin::join<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>(&mut arg0.balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::coin::zero<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>(arg0),
        };
        let v1 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Treasury>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun spend(arg0: &TreasuryCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>>(0x2::coin::split<0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle::XYLE>(&mut arg1.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

