module 0x5a0086fd437f988f1f9bf06f8abbae29fae2da6588432b65b596028a349044c9::taky {
    struct TAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKY>(arg0, 9, b"TAKY", b"TAKY", b"TAKY'S MONEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

