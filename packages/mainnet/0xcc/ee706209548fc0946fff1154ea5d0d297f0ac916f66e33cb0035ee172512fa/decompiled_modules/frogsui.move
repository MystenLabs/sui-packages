module 0xccee706209548fc0946fff1154ea5d0d297f0ac916f66e33cb0035ee172512fa::frogsui {
    struct FROGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGSUI>(arg0, 6, b"FROGSUI", b"Frog SUI", b"First Frog on Turbos Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953839821.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

