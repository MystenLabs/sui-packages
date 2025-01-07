module 0xc9a2de0af380ec27027bf1badb33738d0e74750f8a7e28e619f13670cd9c470d::dmb {
    struct DMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMB>(arg0, 6, b"DMB", b"DUMBO", b"Moon Hard This One", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199153_d682e8c631.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

