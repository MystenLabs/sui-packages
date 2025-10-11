module 0x27eceecfbf2cf5de8dc1f5aa212c3bb7a27e8179d3de3c5b3ad623c8ee507565::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MMT>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MMT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

