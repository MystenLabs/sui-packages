module 0x62848a644cd8b28da3c26512b1fa9e9be55ea79d2aae97e9c6f0fea749af5281::redcat {
    struct REDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDCAT>(arg0, 6, b"REDCAT", b"Redcat", b"Ready to break through any obstacle with 100% focus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0d680368_8947_43b9_9a47_04c31ce9e991_185baea084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

