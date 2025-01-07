module 0xa5f6a261c7dcd7b5b8beaa41fdbbdfcf003d3581f94ef6b79f3879573f22fecf::jk {
    struct JK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JK>(arg0, 9, b"JK", b"Joker", b"We love joker ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31710420-101b-40df-ac27-1637296d94ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JK>>(v1);
    }

    // decompiled from Move bytecode v6
}

