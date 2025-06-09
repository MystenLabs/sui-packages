module 0xa167a6bbeb39fb5bd9731989607e48e4819c670ad5b407bd5bee09b3785114be::mlbb {
    struct MLBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLBB>(arg0, 6, b"MLBB", b"Mobile Legend on Sui", b"Worldwide Moba Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749503911142.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

