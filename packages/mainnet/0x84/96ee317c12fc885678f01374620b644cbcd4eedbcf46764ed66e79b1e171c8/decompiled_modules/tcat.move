module 0x8496ee317c12fc885678f01374620b644cbcd4eedbcf46764ed66e79b1e171c8::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"Taco Cat", b"!now sevil ocat ehT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016557_92382c5c83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

