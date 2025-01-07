module 0x6302f634cc63986c39b84bb096dd52c97a09ac3c6c9936c6d5aca41c25a4b24d::meca {
    struct MECA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECA>(arg0, 6, b"MECA", b"MECA ON SUI", b"$MECA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Yjk6_NOG_400x400_dbcbf42a31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MECA>>(v1);
    }

    // decompiled from Move bytecode v6
}

