module 0x7f7c9acdb64ee1157a97ff3bb6a073322d079b6b9fa7c2e4016c86b6c69659ad::sizzly {
    struct SIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZZLY>(arg0, 6, b"SIZZLY", b"Suizzly", b"Dive into the sweetest corner of the SUI chain $SIZZLY the chubby bear on a mission for endless honey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3829_a701a3377c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

