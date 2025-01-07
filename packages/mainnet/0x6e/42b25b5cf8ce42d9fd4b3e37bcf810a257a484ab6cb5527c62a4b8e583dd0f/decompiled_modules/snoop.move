module 0x6e42b25b5cf8ce42d9fd4b3e37bcf810a257a484ab6cb5527c62a4b8e583dd0f::snoop {
    struct SNOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOP>(arg0, 6, b"SNOOP", b"Snoop In Suioup", b"It's snoop in soup. That's it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016190_ad6b1af71a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

