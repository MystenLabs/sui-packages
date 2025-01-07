module 0xa0e7eddddd6736b85fffde6ecdaa868ba2d02cc48b9082ad12a6b985d418a948::bsc {
    struct BSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSC>(arg0, 9, b"BSC", b"Bsc", b"Binanwe Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6f80e37-2721-4ba7-8ef5-47f7088c9ea4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

