module 0xaae72f39081e72126a432780ec57a17c44ec160e824d3b567aabf170f907d335::registry {
    struct PublisherCap has store, key {
        id: 0x2::object::UID,
    }

    struct Reveal has key {
        id: 0x2::object::UID,
        date: u64,
        kind: u8,
        schema: u8,
        stream: vector<u8>,
        payload: vector<u8>,
    }

    struct Revealed has copy, drop {
        date: u64,
        kind: u8,
        schema: u8,
        stream: vector<u8>,
        reveal_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PublisherCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PublisherCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun reveal(arg0: &PublisherCap, arg1: u64, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 20170101 && arg1 <= 21001231, 0);
        let v0 = 0x1::vector::length<u8>(&arg5);
        assert!(v0 >= 1 && v0 <= 200000, 1);
        let v1 = 0x1::vector::length<u8>(&arg4);
        assert!(v1 >= 1 && v1 <= 32, 2);
        let v2 = Reveal{
            id      : 0x2::object::new(arg6),
            date    : arg1,
            kind    : arg2,
            schema  : arg3,
            stream  : arg4,
            payload : arg5,
        };
        let v3 = Revealed{
            date      : arg1,
            kind      : arg2,
            schema    : arg3,
            stream    : v2.stream,
            reveal_id : 0x2::object::id<Reveal>(&v2),
        };
        0x2::event::emit<Revealed>(v3);
        0x2::transfer::freeze_object<Reveal>(v2);
    }

    // decompiled from Move bytecode v7
}

