module 0x18a99709510ba23478015fbd69719e0f103e5ec40dbc355200ac7adb327ed712::bk {
    struct BK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BK>(arg0, 9, b"BK", b"Baby Kong", b"Baby kong ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65446850-95fa-4c08-9f42-673bced741b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BK>>(v1);
    }

    // decompiled from Move bytecode v6
}

