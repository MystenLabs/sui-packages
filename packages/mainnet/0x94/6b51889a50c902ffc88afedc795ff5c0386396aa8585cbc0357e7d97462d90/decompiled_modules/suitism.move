module 0x946b51889a50c902ffc88afedc795ff5c0386396aa8585cbc0357e7d97462d90::suitism {
    struct SUITISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITISM>(arg0, 6, b"SUITISM", b"SUITISM WORLD", b"$SUITISM on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4115_115f1a7566.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

