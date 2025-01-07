module 0x4f2ae8a93663cb3257dd2b19f7babefd7240ee801def0a02315a473c139e79d9::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"Smile", b"White Smile", b"just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_519956fdd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

