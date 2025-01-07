module 0xe0137914f5b86d5667148b3219d60c29142d9d2fbe54925e1027e7ecba411990::balp {
    struct BALP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALP>(arg0, 6, b"BALP", b"BALP HYBRID", b"BALP IS A HYBRID CHARACTER COMPOSED OF ALL CHARACTERS FROM THE BOYS CLUB  BRETT, LANDWOLF, ANDY & PEPE. HE WAS SURGICALLY ASSEMBLED.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_9b70405eae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALP>>(v1);
    }

    // decompiled from Move bytecode v6
}

