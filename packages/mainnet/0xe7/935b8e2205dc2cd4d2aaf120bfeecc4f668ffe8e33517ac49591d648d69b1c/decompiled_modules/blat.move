module 0xe7935b8e2205dc2cd4d2aaf120bfeecc4f668ffe8e33517ac49591d648d69b1c::blat {
    struct BLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAT>(arg0, 6, b"BLAT", b"Blue The Cat", b"Blue is for cute. Blue is for Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_cat_205b6f792f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

