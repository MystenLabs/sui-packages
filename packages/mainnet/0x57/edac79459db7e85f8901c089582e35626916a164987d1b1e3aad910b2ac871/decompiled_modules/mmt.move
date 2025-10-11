module 0x57edac79459db7e85f8901c089582e35626916a164987d1b1e3aad910b2ac871::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

