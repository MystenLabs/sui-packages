module 0xe6c7a7735071f5d470159d7d5e534d8ccf537577a2d2113641458aa5cc53c0cd::tmp {
    struct TMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMP>(arg0, 9, b"TMP", b"Trump", b"Trump token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11a59130-024c-409c-b2a2-5b6a3bf70220.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

