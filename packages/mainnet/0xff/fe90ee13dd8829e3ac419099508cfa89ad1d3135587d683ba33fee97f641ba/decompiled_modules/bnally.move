module 0xfffe90ee13dd8829e3ac419099508cfa89ad1d3135587d683ba33fee97f641ba::bnally {
    struct BNALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNALLY>(arg0, 9, b"BNALLY", b"Billiz", b"Bnally is building on Sui BLOCKCHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f2658f3-e7ea-4f4c-aa30-90b03daff779.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

