module 0xdd996ae34441193951f6b6ba92f710309bdf21286c943fb81e9cc135dade7e4a::ced {
    struct CED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CED>(arg0, 6, b"CED", b"Close eyed dog", b"Just close your mind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8644d73a0d19eedcd72e71424bdf0921_842229d37a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CED>>(v1);
    }

    // decompiled from Move bytecode v6
}

