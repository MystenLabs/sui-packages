module 0x46ace223c197b03ef2cc53e360aaa1a0bba28d667f666fbbb2ece07743d59b12::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 6, b"DD", b"Destroy Dog", b"Unleash the chaosDestroy Dog is here to break resistance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/407f282e1064ccd4419f830085115007_0bd23b0a52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DD>>(v1);
    }

    // decompiled from Move bytecode v6
}

