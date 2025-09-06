module 0xc69287153734eaf4b1412fe1b8b81b4b8c2a470f2a399e3f59cabaddb3088e88::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 9, b"SUIM", b"SUIMMER", b"Suimming in the Suinami", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v2, @0x1fe081bbe65ea302a5ac3a8dcfb483a87d6936829d8fac55dab2c5e8b4eed990);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

