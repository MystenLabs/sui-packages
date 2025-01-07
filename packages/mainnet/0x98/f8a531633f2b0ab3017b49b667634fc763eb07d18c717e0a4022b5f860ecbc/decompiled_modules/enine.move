module 0x98f8a531633f2b0ab3017b49b667634fc763eb07d18c717e0a4022b5f860ecbc::enine {
    struct ENINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENINE>(arg0, 6, b"ENINE", b"e98", b"e98 cross", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nft_ad8f93326a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

