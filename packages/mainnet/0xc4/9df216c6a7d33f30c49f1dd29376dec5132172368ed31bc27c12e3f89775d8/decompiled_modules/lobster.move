module 0xc49df216c6a7d33f30c49f1dd29376dec5132172368ed31bc27c12e3f89775d8::lobster {
    struct LOBSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBSTER>(arg0, 9, b"LOBSTER", b"LobsterSmokingWeed", x"f09fa69ef09f92b820436c617773206973206c6976696e67207468617420646565702d7365612068696768206c6966652c20636f756e74696e6720737461636b73206f6620426c75654275636b73207768696c652073746179696e67206368696c6c2061742074686520626f74746f6d206f6620746865206f6365616e2120f09f8c8af09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GZpjckfWoAkAwUH?format=jpg&name=small")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOBSTER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBSTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

