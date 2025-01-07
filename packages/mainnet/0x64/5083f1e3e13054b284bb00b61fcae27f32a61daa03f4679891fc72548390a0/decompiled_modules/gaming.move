module 0x645083f1e3e13054b284bb00b61fcae27f32a61daa03f4679891fc72548390a0::gaming {
    struct GAMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMING>(arg0, 9, b"GAMING", b"Builder", b"Gaming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7b3e03a-499b-4def-82d1-5065cb3bcbad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMING>>(v1);
    }

    // decompiled from Move bytecode v6
}

