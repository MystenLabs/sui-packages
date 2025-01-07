module 0xf210bbfed1bbebb4b0e910a18f1ed630744ec3fafbac8a5b6494312957d88c68::goku_ {
    struct GOKU_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU_>(arg0, 9, b"GOKU_", b"GOKU", b"Saiyan Goku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f925567f-cc90-42e5-8747-cb1d98861efc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU_>>(v1);
    }

    // decompiled from Move bytecode v6
}

