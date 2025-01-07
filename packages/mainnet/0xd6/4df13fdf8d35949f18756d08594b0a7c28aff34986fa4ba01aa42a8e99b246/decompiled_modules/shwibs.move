module 0xd64df13fdf8d35949f18756d08594b0a7c28aff34986fa4ba01aa42a8e99b246::shwibs {
    struct SHWIBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHWIBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHWIBS>(arg0, 6, b"SHWIBS", b"Shwibby", b"Long live our lovely girl, Shwibby.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3089_min_2578b93556.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHWIBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHWIBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

