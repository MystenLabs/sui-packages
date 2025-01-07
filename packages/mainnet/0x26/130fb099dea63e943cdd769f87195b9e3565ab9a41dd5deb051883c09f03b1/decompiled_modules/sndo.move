module 0x26130fb099dea63e943cdd769f87195b9e3565ab9a41dd5deb051883c09f03b1::sndo {
    struct SNDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNDO>(arg0, 6, b"SNDO", b"Suinado", b"The Greatest wealth meme token on SUI. A whirlwind/Tornado of growth and excitement in the meme coin space for all of SUI's space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_meme_cartoon_pictu_1_16cbaf2adf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

