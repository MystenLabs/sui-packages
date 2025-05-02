module 0x690e8b06e063f0d3d154333dd80549e7b1d4a09a2f33fee76cdf7b5bad70bf6c::deepo {
    struct DEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPO>(arg0, 6, b"DEEPO", b"Deepo the Whale", b"Meet $DEEPO the Whale. The True mascot of DeepSeekAI. DeepSeekAI shook up the AI industry, and now DEEPO is here to shake up Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deepologonew_f9eef9ea1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

