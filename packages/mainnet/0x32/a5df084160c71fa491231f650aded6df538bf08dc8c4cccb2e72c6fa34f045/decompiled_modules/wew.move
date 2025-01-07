module 0x32a5df084160c71fa491231f650aded6df538bf08dc8c4cccb2e72c6fa34f045::wew {
    struct WEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEW>(arg0, 9, b"WEW", b"Mew", b"Mewew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b0475d4-ff54-4910-8817-ef2dde03edd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

