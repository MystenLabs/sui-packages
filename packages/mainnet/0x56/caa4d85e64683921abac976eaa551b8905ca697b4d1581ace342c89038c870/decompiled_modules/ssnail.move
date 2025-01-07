module 0x56caa4d85e64683921abac976eaa551b8905ca697b4d1581ace342c89038c870::ssnail {
    struct SSNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSNAIL>(arg0, 6, b"SSNAIL", b"Sui Snail", b"Fastest snail to exist. Strongest snail to exist. Lets lead this snail to the moon and beyond! Lets build up a community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_whimsical_vibrant_snail_with_a_neoncolored_1_c42a82e026.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

