module 0xb62b15299f32af916a16be23b968b7a6a01ffb854760e2471cf88a3f2b36e5d3::grump {
    struct GRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMP>(arg0, 6, b"Grump", b"GrumpSui", b"Grumpy memes, happy wallets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_064008635_16c6c37310.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

