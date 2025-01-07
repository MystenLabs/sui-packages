module 0x41f96a48c605c57b569cd57619042f1077eef184cdaef4ab468de34e0f9644ad::suilon {
    struct SUILON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILON>(arg0, 6, b"Suilon", b"Suilon on Sui", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilion_a5cd8785fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILON>>(v1);
    }

    // decompiled from Move bytecode v6
}

