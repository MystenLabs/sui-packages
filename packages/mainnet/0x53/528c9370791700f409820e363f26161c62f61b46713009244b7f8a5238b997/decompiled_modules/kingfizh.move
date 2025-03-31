module 0x53528c9370791700f409820e363f26161c62f61b46713009244b7f8a5238b997::kingfizh {
    struct KINGFIZH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGFIZH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGFIZH>(arg0, 6, b"KINGFIZH", b"Sui King Fizh", b"Life is more funny at sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052770_e25125ac1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGFIZH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGFIZH>>(v1);
    }

    // decompiled from Move bytecode v6
}

