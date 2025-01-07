module 0x7847535c28cdac91d2490d30492c7ce5e3ccdb8ae4bac941aeb8312b33b90f3d::marsik {
    struct MARSIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSIK>(arg0, 6, b"MARSIK", b"MARS", b"ILON MUSK TOKEN MARS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elon_musk_7ceeb1bf8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARSIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

