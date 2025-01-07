module 0xbd8610abc3172fa8b2a02c76f3dc48b3b832ff65b2f1310f75487326cf5e5014::woolfi {
    struct WOOLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOLFI>(arg0, 6, b"WOOLFI", b"Woolfi", b"A barking shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_17_43_10_6184bcabb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

