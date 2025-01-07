module 0x706a4ac013da10da926b0b50fb6e6f3309e667c6a7afd8d1eab6d7fdbea1b522::khello {
    struct KHELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHELLO>(arg0, 9, b"KHELLO", b"KITTYHELLO", b"HELLO KITTY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbdc9c00-a3cd-4469-8561-1fecc8b9a5ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHELLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

