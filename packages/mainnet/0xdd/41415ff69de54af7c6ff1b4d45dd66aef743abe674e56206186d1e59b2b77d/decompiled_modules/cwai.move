module 0xdd41415ff69de54af7c6ff1b4d45dd66aef743abe674e56206186d1e59b2b77d::cwai {
    struct CWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAI>(arg0, 6, b"CWAI", b"Clean Water AI", b"CLEAN WATER AI IS AN IOT DEVICE THAT CONTINUOUSLY MONITORS WATER QUALITY AROUND WATER SOURCES FOR DANGEROUS BACTERIAS AND HARMFUL PARTICLES.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5957_4034e2289a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

