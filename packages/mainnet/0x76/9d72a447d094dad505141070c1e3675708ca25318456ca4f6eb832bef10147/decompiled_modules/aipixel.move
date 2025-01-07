module 0x769d72a447d094dad505141070c1e3675708ca25318456ca4f6eb832bef10147::aipixel {
    struct AIPIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPIXEL>(arg0, 9, b"AIPIXEL", b"APF", b"Ai pixel coin developed on sui blockchain it is working or meta ai and chat GPT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a8ed4fb-929a-473a-8634-074a83603dc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

