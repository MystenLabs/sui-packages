module 0xe3f8c8bcc1d9ccf7da0d2584fa6043500468375b00e61a88c7301cd0f73aa372::mdn {
    struct MDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDN>(arg0, 6, b"MDN", b"MOODENG", b"Meet Moodeng, Thailand's most beloved and adorable pygmy hippo! This token is inspired by the famous Moodeng from Khao Kheow Open Zoo. Created for fans and collectors alike, owning this token is like having a piece of Moodeng with you. Join us in celebrating this unique and charming creature!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726596458623_4c487fb5fd50c9496c5984366d1c0bb4_53b3a71319.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

