module 0x52067b19356a5939c5b43934919303a419a3637b5121f58401e930f47fcdc4ce::bsmp {
    struct BSMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSMP>(arg0, 6, b"BSMP", b"BabySuiMemeParty", b"Baby Sui Meme  PArty ($BMSP) is not another..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_02_52_26_f1315790b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

