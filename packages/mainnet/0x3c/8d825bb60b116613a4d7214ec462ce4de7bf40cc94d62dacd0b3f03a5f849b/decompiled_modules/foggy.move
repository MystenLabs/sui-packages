module 0x3c8d825bb60b116613a4d7214ec462ce4de7bf40cc94d62dacd0b3f03a5f849b::foggy {
    struct FOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGGY>(arg0, 6, b"FOGGY", b"Foggy ", x"6a75737420612068616e64736f6d652066726f6720696e20612062696720706f6e6420f09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731449896305.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

