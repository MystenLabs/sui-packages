module 0x37faea8e815403a9f97b1ed343b4e8f67f2d9363b5400d67323bbb4463aea5f1::vs {
    struct VS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VS>(arg0, 9, b"VS", b"Versa", b"Versar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/988a62c5-92aa-4948-9e4f-0f7e4ec4241e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VS>>(v1);
    }

    // decompiled from Move bytecode v6
}

