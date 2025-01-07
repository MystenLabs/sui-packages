module 0x9bb93fcf68610b8bc5d5e3d147fdc25246f51f84f9d9a2ae342006ced93f40e6::suigi {
    struct SUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGI>(arg0, 6, b"SUIGI", b"Suigi", x"546865206865617274206f66207468697320776f726c6420776173204c756967692c20612068756d626c652079657420636f75726167656f7573206578706c6f726572206b6e6f776e20617320537569676920746f2068697320636f6d70616e696f6e732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_02_39_35_55e6b10bcb_c512d7ba48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

