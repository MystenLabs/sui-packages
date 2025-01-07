module 0x1ac452039988a5b707f46c9b39b9cd59819c90cdca565b23ef052408e9fba546::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 9, b"SUIKO", b"Suikoden2", b"A meme coin that gather all people dan fans suikoden 2 back to their childhood memories and nostalgia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd7e9620-fc74-412d-b894-ce16af847301.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

