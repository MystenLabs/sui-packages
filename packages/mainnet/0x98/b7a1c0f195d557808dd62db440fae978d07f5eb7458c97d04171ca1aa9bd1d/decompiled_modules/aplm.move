module 0x98b7a1c0f195d557808dd62db440fae978d07f5eb7458c97d04171ca1aa9bd1d::aplm {
    struct APLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: APLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APLM>(arg0, 9, b"APLM", b"Apolomax", b"token distribution ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ff3b5a5-d656-445b-a0ae-7f3265dc623b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

