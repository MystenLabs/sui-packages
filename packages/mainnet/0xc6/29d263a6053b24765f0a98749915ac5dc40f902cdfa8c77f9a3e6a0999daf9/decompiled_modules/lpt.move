module 0xc629d263a6053b24765f0a98749915ac5dc40f902cdfa8c77f9a3e6a0999daf9::lpt {
    struct LPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPT>(arg0, 9, b"LPT", b"Little Pig", b"Think about meme and rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fc2b1ee-189a-4191-bc79-7cddbe1feb73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

