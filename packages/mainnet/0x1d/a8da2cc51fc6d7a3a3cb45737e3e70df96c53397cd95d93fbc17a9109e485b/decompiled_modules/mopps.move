module 0x1da8da2cc51fc6d7a3a3cb45737e3e70df96c53397cd95d93fbc17a9109e485b::mopps {
    struct MOPPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPPS>(arg0, 6, b"Mopps", b"mopps", b"happ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732939739876.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOPPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

