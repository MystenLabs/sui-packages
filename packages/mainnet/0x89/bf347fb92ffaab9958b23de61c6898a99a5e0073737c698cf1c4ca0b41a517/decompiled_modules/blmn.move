module 0x89bf347fb92ffaab9958b23de61c6898a99a5e0073737c698cf1c4ca0b41a517::blmn {
    struct BLMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLMN>(arg0, 9, b"BLMN", b"blue moon", b"Develop Moon Memecoin, a fun and engaging cryptocurrency inspired by the allure of space travel, with unique moon-themed branding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47d37a42-39bf-4fca-92fa-a0362cdd8d1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

