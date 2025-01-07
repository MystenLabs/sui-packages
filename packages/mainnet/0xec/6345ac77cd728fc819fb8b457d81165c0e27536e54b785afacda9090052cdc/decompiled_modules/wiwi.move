module 0xec6345ac77cd728fc819fb8b457d81165c0e27536e54b785afacda9090052cdc::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWI>(arg0, 9, b"WIWI", b"Wikiki", b"All about fun and fund", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd8939e5-8559-4f52-a9e8-a9acb0219520.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

