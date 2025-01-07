module 0x8f63f6c8c6a9fec8218986d5a46fb6d102d64fe7bf8137ed4ff43b75c861a0b0::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Aitouch", b"Aitouch is a simple AI based tool that creates professional and effective content in a few simple steps. The perfect solution to save time and improve the quality of your content. Everything you need to create professional-grade content easily and quickly in one window. Our AI tools help marketers, influencers, editors and even business owners save resources and time and focus on the tasks that really matter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frame_16_a09662b657.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

