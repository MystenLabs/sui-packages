module 0x8b56cad61e7547564766660322ed0bdd51f0e4f653bbbdc807e4db8658bb5bf5::suipants {
    struct SUIPANTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANTS>(arg0, 9, b"SUIPANTS", b"SPONGEBOB SUIPANTS LP", b"SUIPANTS on BLUEMOVE LIQUIDITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPANTS>(&mut v2, 200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPANTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

