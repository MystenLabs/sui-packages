module 0xb5ab8f813e98a357da7b5807370e618ff7260264bbd0b7a3627ad92562b15473::eight {
    struct EIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIGHT>(arg0, 9, b"EIGHT", b"TwentyEigh", b"83 86 mai dinh mai dinh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c117b591-509c-4dac-bbf7-97f8ec87b767.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

