module 0xcf3c8d397de3cce3d334830014dbbb00b43dbb93e25b4d0c390a67dfdf51cca9::rook {
    struct ROOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOK>(arg0, 6, b"ROOK", b"SUIS ROOK", b"dcfe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955229537.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

