module 0x339d6bc9ac9d3ee7c7f8415ff84a4d7ca80f3a91f1dd36e91d050af668753f6a::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 6, b"SWIF", b"suiwifhat", x"57656c636f6d6520746f20245a5749460a6d656f7777772c206e69636520746f206d65657420796f750a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zeekhead_e3307dfe_12dc6715d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

