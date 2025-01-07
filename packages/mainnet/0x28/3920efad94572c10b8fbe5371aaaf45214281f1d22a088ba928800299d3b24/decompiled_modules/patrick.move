module 0x283920efad94572c10b8fbe5371aaaf45214281f1d22a088ba928800299d3b24::patrick {
    struct PATRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRICK>(arg0, 6, b"PATRICK", b"PATRICK STAR", b"Born in the whimsical world of crypto, Patrick the Star was created with one mission: spread joy and laughter across the blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958372894.25")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PATRICK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRICK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

