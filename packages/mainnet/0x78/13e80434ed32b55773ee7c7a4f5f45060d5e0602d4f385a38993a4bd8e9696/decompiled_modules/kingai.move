module 0x7813e80434ed32b55773ee7c7a4f5f45060d5e0602d4f385a38993a4bd8e9696::kingai {
    struct KINGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGAI>(arg0, 6, b"KINGAI", b"test", b"this is description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_4f387ad21f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

