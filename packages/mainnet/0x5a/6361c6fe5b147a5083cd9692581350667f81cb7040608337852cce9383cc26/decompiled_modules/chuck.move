module 0x5a6361c6fe5b147a5083cd9692581350667f81cb7040608337852cce9383cc26::chuck {
    struct CHUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUCK>(arg0, 6, b"CHUCK", b"CHUCK on SUI", x"436875636b6c65436f696e2069732061206d656d65207468617420636f6d62696e65732066756e20616e6420696e766573746d656e742c206f66666572696e6720612076696272616e7420636f6d6d756e69747920696e737069726564206279206d656d652063756c747572650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BR_Gw_XX_59_400x400_4461e3a78e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

