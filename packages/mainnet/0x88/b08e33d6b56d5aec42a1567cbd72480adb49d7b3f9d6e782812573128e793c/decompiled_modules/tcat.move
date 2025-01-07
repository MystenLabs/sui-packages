module 0x88b08e33d6b56d5aec42a1567cbd72480adb49d7b3f9d6e782812573128e793c::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"Tank Cat", b"Tank cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2113_5fdefd17fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

