module 0x807146504554bc68e704c4549e01d0340aec9a774b5d3ffaf5b026ab2fd56f39::kt {
    struct KT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KT>(arg0, 9, b"KT", b"King top ", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bc48e26-595c-4c88-a189-fb18915388c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KT>>(v1);
    }

    // decompiled from Move bytecode v6
}

