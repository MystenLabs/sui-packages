module 0xe7d00451ab7bd82a9ec420aec653492df3373f8ad46692e0545231b423de2ef9::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 6, b"LONG", b"LONG CAT", b"Long cat OG meme now on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6846_85263b1425.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

