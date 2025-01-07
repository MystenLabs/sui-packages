module 0x30afdf000d24679aeb670b4a009d746129aff6e24ca4b3b5ad9b479fe1f6197b::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"Poring", b"PoringSui", b"$PORING - The first memcoin on $SUI blockchain with fair distribution on the http://hop.fun platform on October 12", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poring_25950db99c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORING>>(v1);
    }

    // decompiled from Move bytecode v6
}

