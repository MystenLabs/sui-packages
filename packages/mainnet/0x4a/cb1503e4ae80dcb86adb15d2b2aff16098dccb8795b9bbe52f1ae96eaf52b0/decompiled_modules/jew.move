module 0x4acb1503e4ae80dcb86adb15d2b2aff16098dccb8795b9bbe52f1ae96eaf52b0::jew {
    struct JEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEW>(arg0, 9, b"JEW", b"BADIEE", b"BADIEEJEWELERY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de98435a-1f0f-4f99-b7ba-5bd6defe72e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

