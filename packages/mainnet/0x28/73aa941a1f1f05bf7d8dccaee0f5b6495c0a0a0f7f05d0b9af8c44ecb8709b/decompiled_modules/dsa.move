module 0x2873aa941a1f1f05bf7d8dccaee0f5b6495c0a0a0f7f05d0b9af8c44ecb8709b::dsa {
    struct DSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSA>(arg0, 9, b"DSA", b"ASD", b"CoinDesc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61xa1mU0OYL._AC_UF1000,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

