module 0x6769f981a27605a0d53e59ab8e85dde7871f6ac8d8207af654134861cb4fa9b2::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"FART", b"Green Fart", b"Join the magic world of the fartonians! A world of Farts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024653_a3106f99e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FART>>(v1);
    }

    // decompiled from Move bytecode v6
}

