module 0xcb9eb5553883534b436087d1266141bdfdb2701fb1ba29a3b958c6824f38e025::dkc {
    struct DKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKC>(arg0, 9, b"DKC", b"Duc kheo", b"Meme spontaneous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a58cdb4-cb39-4621-b4e0-82f369bd9971.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

