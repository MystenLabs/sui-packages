module 0x52696fa11d4d693b18d24d4c70d33c6422a46759c380a4c90bf802a303211a16::sgk {
    struct SGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGK>(arg0, 9, b"SGK", b"Songoku", b"SONGOKU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ede9eade-2261-411c-83fd-a4a72b9c712b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGK>>(v1);
    }

    // decompiled from Move bytecode v6
}

