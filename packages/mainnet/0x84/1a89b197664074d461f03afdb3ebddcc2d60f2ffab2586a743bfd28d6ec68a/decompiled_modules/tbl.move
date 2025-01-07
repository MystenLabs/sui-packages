module 0x841a89b197664074d461f03afdb3ebddcc2d60f2ffab2586a743bfd28d6ec68a::tbl {
    struct TBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBL>(arg0, 9, b"TBL", b"DOG TIBALT", b"TBL - token of AV8.FUND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbdbcaa9-c902-4180-ac1b-05029e92465f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

