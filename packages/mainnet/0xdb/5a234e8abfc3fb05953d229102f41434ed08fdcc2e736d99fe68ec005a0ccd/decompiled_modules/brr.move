module 0xdb5a234e8abfc3fb05953d229102f41434ed08fdcc2e736d99fe68ec005a0ccd::brr {
    struct BRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRR>(arg0, 9, b"BRR", b"Kotya", b"November.... brrrr....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/289d71b5-8dff-443c-b15f-543e807c3688.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

