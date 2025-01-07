module 0x5300cfae8a5f0aa3c24dfa4a8c0fc58a8174fdde6f7a03922b537d04243596eb::titcock1 {
    struct TITCOCK1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITCOCK1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITCOCK1>(arg0, 6, b"TitCock1", b"Tikcock", b"Just a cock on TikC0ck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1_e81c1ef4e8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITCOCK1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITCOCK1>>(v1);
    }

    // decompiled from Move bytecode v6
}

