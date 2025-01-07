module 0x731259d217b35106fd3ceae2f084747a5972a8b67d110e93949d1688c5a2649a::zar {
    struct ZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAR>(arg0, 9, b"ZAR", b"ZAAR", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69bdd1e6-cde9-4944-9764-ab204681816f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

