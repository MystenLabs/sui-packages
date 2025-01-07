module 0x114701e40fd0d3987ae510b449bce11c1c7c7df04ef3205fd9c99fe20568f49f::mull {
    struct MULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULL>(arg0, 6, b"Mull", b"Mullet Dog", b"The mullet isnt just a haircut, its a lifestyle. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2008_84513b44f5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

