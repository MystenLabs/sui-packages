module 0x44e50925ea6a12c71088b4e6ce9483f97dc751629913880511458dbced6e80dc::trr {
    struct TRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRR>(arg0, 9, b"TRR", b"Terror", b"TERROR THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/693cbe74-19d9-4fca-860e-d4171f177b10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

