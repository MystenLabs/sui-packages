module 0xaa81f8112fd6516b9b2ac1da19d67e2e3a5260bc8f5580a96f9a064bd5b7443f::govo {
    struct GOVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOVO>(arg0, 9, b"GOVO", b"$GOVO", b"This is GOVO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOVO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOVO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

