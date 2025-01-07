module 0x161b32d6868b9a7493953c9bcf8851e03541462788a365647d46f0c229b6e0a4::suigpt {
    struct SUIGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGPT>(arg0, 6, b"SUIGPT", b"SUIGPT4", b"SUIGPT IS THE NEW ARTIFICIAL INTELLIGENCE BOT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_21_04_04_9b06c8bd08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

