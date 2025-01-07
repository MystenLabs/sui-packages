module 0xf081e7ccc16dff8137774e56b581eccfbe0e8926b19d3242b767b9b039cdd46d::goldbeav {
    struct GOLDBEAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDBEAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDBEAV>(arg0, 6, b"GOLDBEAV", b"GoldBeav", b"$GOLDBEAV Humorously Depicts The Loved Daily Life Of Modern People, Symbolically expressing the repetitive routine, The brief respite of couples and spirit of starting another kiss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/666666666_b03e4d96b2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDBEAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDBEAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

