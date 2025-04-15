module 0xf2875082b01b9cf59137ceb98be5873c29629534e987d1f9ffaf297eee4407df::qrkl {
    struct QRKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRKL>(arg0, 9, b"QRKL", b"Quirkle", x"54686520746f6b656e206f662064656c6967687466756c2072616e646f6d6e6573732e205573652051524b4c20696e2067616d65732c206c6f747465726965732c206f72206a75737420666f722066756e2e2045766572792051524b4c207472616e73616374696f6e20686173206120747769737420e28094206578706563742074686520756e65787065637465642c20616e6420656d62726163652074686520717569726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/add1833adc622c734250e53a6a82a73fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QRKL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRKL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

