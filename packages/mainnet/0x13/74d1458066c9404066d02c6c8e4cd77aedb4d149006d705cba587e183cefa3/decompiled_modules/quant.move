module 0x1374d1458066c9404066d02c6c8e4cd77aedb4d149006d705cba587e183cefa3::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"Quant", b"Gen Z quant", b"The kid who rugged for 20k on live stream. Can this beat the Solana MC?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732080311378.23")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

