module 0xa5def18a93c6fa81d1efeb2a201f9bc1adc4feebea146373bccfa1c886db80e3::suikea {
    struct SUIKEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEA>(arg0, 6, b"SUIKEA", b"suikea", x"68747470733a2f2f7777772e7375696b65612e73746f72652f0a68747470733a2f2f782e636f6d2f7375696b65616f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikea_8e1653b280.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

