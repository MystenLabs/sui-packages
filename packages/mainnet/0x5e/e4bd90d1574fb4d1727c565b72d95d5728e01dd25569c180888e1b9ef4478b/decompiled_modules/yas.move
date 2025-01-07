module 0x5ee4bd90d1574fb4d1727c565b72d95d5728e01dd25569c180888e1b9ef4478b::yas {
    struct YAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAS>(arg0, 6, b"YAS", b"YourAI on Sui", b"AI companion, accompanying you to explore the crypto universe. With the ability to deeply analyze the market and make accurate predictions, YourAI Sui will help you make wise investment decisions. Let's build a strong community and share the joy of investing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_96ce08b2ca.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

