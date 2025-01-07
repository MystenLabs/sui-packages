module 0x75172d866c2c7418959154d255028ebd94df453ff60b9ac7ce44c50a144fd653::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 9, b"BLM", b"BLUM", b"Blum lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b32e7272-4554-4ec3-a8d6-a27c37323dce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

