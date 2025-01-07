module 0x6c304237028f0d447c235cae50614ca5f1503e5962120fd2818a0a9f29103ab6::soon {
    struct SOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOON>(arg0, 6, b"SOON", b"Diamante", b"Diamante $Soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241123_210457_864_e1f4971a08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

