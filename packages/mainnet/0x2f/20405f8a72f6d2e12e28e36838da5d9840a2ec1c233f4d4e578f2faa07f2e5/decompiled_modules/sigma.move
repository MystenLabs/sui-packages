module 0x2f20405f8a72f6d2e12e28e36838da5d9840a2ec1c233f4d4e578f2faa07f2e5::sigma {
    struct Stream has store, key {
        id: 0x2::object::UID,
        from: address,
        to: address,
        ratePerSec: u64,
        lastUpdate: u64,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun createStream(arg0: address, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Stream{
            id         : 0x2::object::new(arg4),
            from       : arg0,
            to         : arg1,
            ratePerSec : arg2,
            lastUpdate : 0x2::clock::timestamp_ms(arg3),
            balance    : 0x2::coin::zero<0x2::sui::SUI>(arg4),
        };
        0x2::transfer::public_share_object<Stream>(v0);
    }

    public entry fun deposit(arg0: &mut Stream, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public entry fun withdraw(arg0: &mut Stream, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.to, 9223372397632028671);
        let v1 = (0x2::clock::timestamp_ms(arg1) - arg0.lastUpdate) * arg0.ratePerSec;
        let v2 = v1;
        if (v1 > 0x2::coin::value<0x2::sui::SUI>(&arg0.balance)) {
            v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0.balance);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v2, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

