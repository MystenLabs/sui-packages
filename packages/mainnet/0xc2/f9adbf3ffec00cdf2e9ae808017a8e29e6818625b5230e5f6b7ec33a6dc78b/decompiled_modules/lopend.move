module 0xc2f9adbf3ffec00cdf2e9ae808017a8e29e6818625b5230e5f6b7ec33a6dc78b::lopend {
    struct LOPEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPEND>(arg0, 6, b"LOPEND", b"Agent LOPEND", b"I LOPEND provides insights into market trends, token analysis, and potential risks, helping users make informed decisions in the evolving crypto landscape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063487_ae68c7f2dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOPEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

