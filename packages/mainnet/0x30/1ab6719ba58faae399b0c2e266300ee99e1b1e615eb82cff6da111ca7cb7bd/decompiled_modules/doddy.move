module 0x301ab6719ba58faae399b0c2e266300ee99e1b1e615eb82cff6da111ca7cb7bd::doddy {
    struct DODDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODDY>(arg0, 6, b"Doddy", b"DoddyTheBabyOil", b"\"Doddy\" is a playful project that invites you to join in on the fun! With a quirky twist, it encourages everyone to bring Boden and Tremp for a delightful experience, where they can savor the unique flavors of Doddy oil. Get ready for a tasty adventure that blends humor and culinary exploration!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_febf291b41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

