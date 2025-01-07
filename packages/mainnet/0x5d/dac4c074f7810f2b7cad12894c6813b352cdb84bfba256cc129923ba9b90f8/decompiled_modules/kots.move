module 0x5ddac4c074f7810f2b7cad12894c6813b352cdb84bfba256cc129923ba9b90f8::kots {
    struct KOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTS>(arg0, 6, b"KOTS", b"KING OF THE SEA", b"Swimming chicken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Swimming_170537e9af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

