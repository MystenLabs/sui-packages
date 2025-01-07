module 0x43649c7284c7087fd2415fb3c771f2c4b229b4451bca7faae5f71a498c30629c::suleman {
    struct SULEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULEMAN>(arg0, 6, b"Suleman", b"Suileman", b"Okey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8841c817915a01a4ef82d2b3e916b9a7_5803d3dc32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

