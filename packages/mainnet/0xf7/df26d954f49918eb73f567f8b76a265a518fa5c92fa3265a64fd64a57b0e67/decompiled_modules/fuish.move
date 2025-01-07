module 0xf7df26d954f49918eb73f567f8b76a265a518fa5c92fa3265a64fd64a57b0e67::fuish {
    struct FUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUISH>(arg0, 6, b"FUISH", b"SUI FUISH", b"Just a fish in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/P_Ed2_UHNL_400x400_ae97748a86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

