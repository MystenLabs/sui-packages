module 0x4241f49f31b686611c9d454875e8a3d4b589272ef34ac0a8291c2cfde0970e4e::spk {
    struct SPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPK>(arg0, 6, b"SPK", b"SPARKLE PANDA", b"Cute, shiny, and fiercely determined to outshine every memecoin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_025826303_6044c35bb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

