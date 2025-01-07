module 0x8a923ee7ac69b52db2a9842b936af1292a7083f6677b75637c306842bc51065a::wiwk {
    struct WIWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWK>(arg0, 9, b"WIWK", b"ejej", b"djdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/119ced9f-8212-4454-8fe9-f8cf35ab558b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

