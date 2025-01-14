module 0x1867051c9435b70759a2be31c64b40da34924c64b2373ffb994a3dc65c49683a::tel {
    struct TEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEL>(arg0, 9, b"tel", b"tel aviv", b"aviv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

