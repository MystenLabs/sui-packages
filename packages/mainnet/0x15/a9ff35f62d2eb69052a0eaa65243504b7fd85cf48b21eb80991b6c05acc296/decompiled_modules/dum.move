module 0x15a9ff35f62d2eb69052a0eaa65243504b7fd85cf48b21eb80991b6c05acc296::dum {
    struct DUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUM>(arg0, 9, b"DUM", b"Dummy", b"Dummy panda not a real panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95a4be5c-2dba-42a8-95e9-20b02bd637da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

