module 0x4957041dcc676de5258a935e801314517177ad477d5783a135d8c531bc6048e6::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 6, b"Musk", b"musk", b"Musk musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977059441.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

