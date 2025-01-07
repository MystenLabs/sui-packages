module 0xf8e13e5f6e439b20ca02cf9c98ce9a2bb38741f1305036443c30ed8dfb129d2::suimander {
    struct SUIMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANDER>(arg0, 6, b"SUIMANDER", b"$SUIMANDER", b"Meet $SUIMANDER, the world's first degenerate gambling salamander, native to the blockchain waters of SUI and amphibian cousin of PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_6_46bb06c9c3_e71ac603e3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

