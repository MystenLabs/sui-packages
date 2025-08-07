module 0xc2377136e945d2ae430b11b45db62e2150c81c256660e000a2a29fc5b2bdc2ad::shibhood {
    struct SHIBHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBHOOD>(arg0, 6, b"SHIBHOOD", b"ShibaHood", b"The Shiba that steals from the rich, and gives to the memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_The_legend_begins_ba912eeb37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBHOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

