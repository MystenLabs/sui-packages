module 0x8b8488d46bd545ded352830da23961e6bf90560a83b88ae740eef6048714ce0f::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPEPE>(arg0, 6, b"AAAPEPE", b"aaaPEPE", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaapepe_962c86c65b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

