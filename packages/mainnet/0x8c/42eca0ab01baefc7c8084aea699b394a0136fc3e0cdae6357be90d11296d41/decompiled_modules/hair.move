module 0x8c42eca0ab01baefc7c8084aea699b394a0136fc3e0cdae6357be90d11296d41::hair {
    struct HAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIR>(arg0, 6, b"HAIR", b"MOSHAIR", b"Best Hair on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOSHAIR_9200747832.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

