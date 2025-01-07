module 0xb4c0fd1a074e31fff40641720dd03fc32e498e5e0d2a89f043fbdb007c52d3f3::aeae {
    struct AEAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEAE>(arg0, 6, b"Aeae", b"aeaeae", b"aeaeaae", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_97_c65e6a1061.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

