module 0x107688a6c79556538b549685f4a867840b2989fc958182d12aec76c0abceabc7::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 6, b"SP", b"Sui-Pernova", b"Meme that will explode like superNova", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Create_a_vibrant_logo_for_a_new_meme_coin_cal_0_9b785b1517.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP>>(v1);
    }

    // decompiled from Move bytecode v6
}

