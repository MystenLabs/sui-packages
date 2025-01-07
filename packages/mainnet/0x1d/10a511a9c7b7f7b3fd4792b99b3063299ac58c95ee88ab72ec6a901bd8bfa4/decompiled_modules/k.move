module 0x1d10a511a9c7b7f7b3fd4792b99b3063299ac58c95ee88ab72ec6a901bd8bfa4::k {
    struct K has drop {
        dummy_field: bool,
    }

    fun init(arg0: K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K>(arg0, 9, b"K", b"Kei", b"Meme token in wave network, for elegant holders. Utility includes buying, selling, trading, benefits for holders, and burning of token every week and more to follow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15a22eb5-a815-40e3-ad0c-d03e9aab12d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K>>(v1);
    }

    // decompiled from Move bytecode v6
}

