module 0xbe0dad3edc808b5d1e9ad9f43386d113993b44c99f9141c0a781cae0b780ca0c::wdr {
    struct WDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDR>(arg0, 9, b"WDR", b"Withdraw", b"deposit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a634563-9c58-4163-86a6-5f9cf2e0ac4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

