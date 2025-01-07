module 0xa1255a0434157649c5ae1bb866e9ae55398a5004bb153363a0a7275b9f97f84d::sis {
    struct SIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIS>(arg0, 6, b"SIS", b"Suinny in Suizhou", x"5375696e6e792074686520526574617264696f206973206c6f737420696e205375697a686f75204368696e6120616761696e210a48656c702068696d2066696e6420686973206d6f6d6d7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINNY_REAL_71b67da6a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

