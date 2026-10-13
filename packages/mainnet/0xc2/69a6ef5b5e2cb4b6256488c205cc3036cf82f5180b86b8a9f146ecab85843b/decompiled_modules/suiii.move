module 0xc269a6ef5b5e2cb4b6256488c205cc3036cf82f5180b86b8a9f146ecab85843b::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nSUIIIII";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dSUII";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/Q86QIcuNEFVtpkXH")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIII>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

