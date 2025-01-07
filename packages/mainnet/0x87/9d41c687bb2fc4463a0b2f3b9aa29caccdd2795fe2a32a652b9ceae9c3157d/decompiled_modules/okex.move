module 0x879d41c687bb2fc4463a0b2f3b9aa29caccdd2795fe2a32a652b9ceae9c3157d::okex {
    struct OKEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKEX>(arg0, 9, b"OKEX", b"OKX", b"Kotex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e504e4cf-aadc-469b-993f-8510a9c223b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

