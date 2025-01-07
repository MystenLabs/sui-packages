module 0xb503385f757ecf61bb32bc502fd0b2e90e22253c9d32b66104acf708afe5506a::ccdfen {
    struct CCDFEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCDFEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCDFEN>(arg0, 6, b"CCDFEN", b"Chinese Communist Dragon FENTANYL", b"The Fentanyl Dragon has taken over America and owns your debt, vaccines, and its sending drugs into your streets...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fentanyl_11ec54578c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCDFEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCDFEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

