module 0xf03235c3105a2dcc250105368a47e6a094113d3d80be131d9653c61f15806f71::kt {
    struct KT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KT>(arg0, 9, b"KT", b"Love KimT", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/150bfcb0-edb6-41b1-9136-5b86a7b71f7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KT>>(v1);
    }

    // decompiled from Move bytecode v6
}

