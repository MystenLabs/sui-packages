module 0xd8235b0a5ddae5dc667641dd55f327d12e4b76ccf2f7e4f376bc14abb631cd5f::dmb {
    struct DMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMB>(arg0, 6, b"DMB", b"DUMBO", b"Moon this one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199153_b573b71b93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

