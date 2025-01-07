module 0x2b8a3ddce4bb62f78fe5d7f80a9a7fe747135a58ea7c7ade3ce0dcf8ba491a08::twump {
    struct TWUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWUMP>(arg0, 6, b"TWUMP", b"DONNA TWUMP", b"Donna Twump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4119_d55539b7bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

