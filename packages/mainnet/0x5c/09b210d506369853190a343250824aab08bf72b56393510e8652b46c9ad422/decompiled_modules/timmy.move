module 0x5c09b210d506369853190a343250824aab08bf72b56393510e8652b46c9ad422::timmy {
    struct TIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMMY>(arg0, 6, b"TIMMY", b"Timmy", b"Hey yall so Im a 16 year old kid and making my first project. I will make all the socials and website soon. Just wanted to get this up and moving. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6949_cffb155885.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

