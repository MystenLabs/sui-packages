module 0xbc379d2284109ed1333f122740077d35890fa362d809c192cb74dd3eb4709888::popi {
    struct POPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPI>(arg0, 6, b"POPI", b"Sui Popi", b"Dive into deep sea and found $POPI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_63_a17537a20e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

