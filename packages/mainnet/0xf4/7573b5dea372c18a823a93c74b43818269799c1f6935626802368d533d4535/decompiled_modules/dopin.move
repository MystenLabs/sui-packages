module 0xf47573b5dea372c18a823a93c74b43818269799c1f6935626802368d533d4535::dopin {
    struct DOPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPIN>(arg0, 6, b"Dopin", b"DopinTheDolphin", b"The doped community project making waves on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Lx_Wota_AAA_Pc_J3_f747596aa2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

