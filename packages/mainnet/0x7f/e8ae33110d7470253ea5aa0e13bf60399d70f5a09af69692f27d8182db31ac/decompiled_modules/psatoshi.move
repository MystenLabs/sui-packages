module 0x7fe8ae33110d7470253ea5aa0e13bf60399d70f5a09af69692f27d8182db31ac::psatoshi {
    struct PSATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSATOSHI>(arg0, 9, b"PSATOSHI", b"peter todd", b"peter todd is satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ba44163-62dd-4f88-88f1-f31bcff62adf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

