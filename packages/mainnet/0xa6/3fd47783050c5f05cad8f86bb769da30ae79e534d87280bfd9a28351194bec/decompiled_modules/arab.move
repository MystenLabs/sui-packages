module 0xa63fd47783050c5f05cad8f86bb769da30ae79e534d87280bfd9a28351194bec::arab {
    struct ARAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAB>(arg0, 6, b"ARAB", b"ZEMMOUR", b"The best Soral token on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soral_633678cdf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

