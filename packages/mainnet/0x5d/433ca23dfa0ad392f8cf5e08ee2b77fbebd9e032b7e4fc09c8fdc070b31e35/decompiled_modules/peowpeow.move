module 0x5d433ca23dfa0ad392f8cf5e08ee2b77fbebd9e032b7e4fc09c8fdc070b31e35::peowpeow {
    struct PEOWPEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOWPEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOWPEOW>(arg0, 6, b"PEOWPEOW", b"PEOW PEOW", b"If you cant handle the meow meow you get the peow peow! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_22_41_15_1461e3adeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOWPEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOWPEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

