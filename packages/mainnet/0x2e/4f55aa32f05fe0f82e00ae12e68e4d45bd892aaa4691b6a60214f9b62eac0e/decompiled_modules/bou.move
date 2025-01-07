module 0x2e4f55aa32f05fe0f82e00ae12e68e4d45bd892aaa4691b6a60214f9b62eac0e::bou {
    struct BOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOU>(arg0, 9, b"BOU", b"Bousum", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1afb136-e1a9-4ff1-b564-17716b4949a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

