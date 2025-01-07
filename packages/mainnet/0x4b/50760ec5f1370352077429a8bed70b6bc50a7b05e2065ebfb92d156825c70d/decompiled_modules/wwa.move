module 0x4b50760ec5f1370352077429a8bed70b6bc50a7b05e2065ebfb92d156825c70d::wwa {
    struct WWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWA>(arg0, 9, b"WWA", b"Wood", b"Wood the best meme ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7564d9c-94e9-433e-b7a2-f52ab98720c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

