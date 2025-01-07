module 0xc5c0e14c1d150ed9f1f9472c2caf62af80bb29b60bed4a89d394bd97660018a::pugtug {
    struct PUGTUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGTUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGTUG>(arg0, 6, b"PUGTUG", b"Pug Boat", b"all bark, no byte", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050759_726e2ac25c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGTUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGTUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

