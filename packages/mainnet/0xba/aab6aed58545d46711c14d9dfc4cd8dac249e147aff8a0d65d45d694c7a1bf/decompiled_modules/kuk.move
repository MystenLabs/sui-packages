module 0xbaaab6aed58545d46711c14d9dfc4cd8dac249e147aff8a0d65d45d694c7a1bf::kuk {
    struct KUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUK>(arg0, 9, b"KUK", b"Kukoi", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f79a2971-0903-4748-b948-061d49edeb64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

