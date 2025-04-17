module 0xc9ba5ef89ef36e93c962698cc6db30dbae33cc7a5cfada131185f74c327b4f3f::puga {
    struct PUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGA>(arg0, 6, b"PUGA", b"$PUGA", b"La moneda que te hace vibrar en abundancia!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2025_03_26_183719_06d07da8b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

