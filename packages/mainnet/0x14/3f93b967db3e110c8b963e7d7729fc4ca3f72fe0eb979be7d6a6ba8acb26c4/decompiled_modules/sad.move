module 0x143f93b967db3e110c8b963e7d7729fc4ca3f72fe0eb979be7d6a6ba8acb26c4::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"Blue Eyed Sadness", b"A blue eyed Sad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_eyed_d2490938ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

