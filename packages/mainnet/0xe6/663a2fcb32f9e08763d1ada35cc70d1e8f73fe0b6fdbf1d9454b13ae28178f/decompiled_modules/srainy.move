module 0xe6663a2fcb32f9e08763d1ada35cc70d1e8f73fe0b6fdbf1d9454b13ae28178f::srainy {
    struct SRAINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRAINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRAINY>(arg0, 6, b"Srainy", b"Rainysu", b"Rainysu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fdgdfgdf_966ec04b2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRAINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRAINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

