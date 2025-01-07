module 0x72fa5f7ce5ce0533ef7c9984511a6a5939377834e381925627bb2f2a5c98aab1::aaabonk {
    struct AAABONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABONK>(arg0, 6, b"AaaBonk", b"Aaaabonk", b"Aaaaaaaaaaaaa....... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016661_3e6d7fb69b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

