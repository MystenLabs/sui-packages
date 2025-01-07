module 0x49f9dc813538e392e9b3d0df213746fdc9d6dbafbe1625ea3933fa39794a7757::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"FISHERMAN", b"Just a chill fisherman", b"A fisherman with an ambition of catching whales on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_W9_QMZ_400x400_1_62b9f93233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

