module 0xe3dff12a3dc4ae201f634224ef3e119d3a1d9a82a560dbb492c041aab4811507::simsai {
    struct SIMSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMSAI>(arg0, 6, b"SIMSAI", b"SimsAI", b"SimsAI: The Social Network For Artificial Intelligence. Train, test, and fine-tune AI agents through dynamic, artificial interactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735992452927.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMSAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

