module 0x8b6ebf86f155d127a107af703a192672336b878dcdd0c0ffaa4959fa73a74aa8::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAPPY>(arg0, 6, b"FLAPPY", b"Flappy The bat", x"50726573656e74696e6720746865206368617261637465722074686174204d617474204675726965204c6f76657320546f204472617720546865204d6f737421202050657065204d617920426520746865206d6f737420706f70756c61522c20486f707059204d617920426520546865204d6f7374204163636c61696d656420416e64205370696b65204d6179206265205468652066697273742c20427574207468657920617265206e6f742054686569722043726561746f722773206661766f726974652120546861742044697374696e6374696f6e2042656c6f6e677320536f6c656c7920546f20464c41505059210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_ce8553c686.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

