module 0x4d02e18b0defb15175d024c0ff2023165a2f579bff9a5e1cf4ef2584b12e6b58::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 6, b"Dogs", b"Dogs on sui", b"meme inspired by CZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_14_10_39_9d8cbb05c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

