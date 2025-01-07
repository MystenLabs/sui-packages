module 0xeadd1b7d7a55b27eb684e535106ad9e3b39b8d0474f04dd1c2e275626dea617d::quantnice {
    struct QUANTNICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTNICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTNICE>(arg0, 6, b"QUANTNICE", b"QUANTNICE on SUI", b"Nice guy before rug!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gczs93_Ubc_AAZ_Sx_K_3fc9cfeb5c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTNICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTNICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

