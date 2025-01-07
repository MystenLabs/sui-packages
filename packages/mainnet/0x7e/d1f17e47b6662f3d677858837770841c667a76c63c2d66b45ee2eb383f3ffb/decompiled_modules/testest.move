module 0x7ed1f17e47b6662f3d677858837770841c667a76c63c2d66b45ee2eb383f3ffb::testest {
    struct TESTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTEST>(arg0, 9, b"testest", b"random coin", b"ddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTEST>(&mut v2, 123456000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

