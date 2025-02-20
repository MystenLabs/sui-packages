module 0xb3de5aa79e031e375a7972743438110ab0935d59eaaf8e81b9ee1f74e7332792::TONKO2 {
    struct TONKO2 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TONKO2>, arg1: 0x2::coin::Coin<TONKO2>) {
        0x2::coin::burn<TONKO2>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TONKO2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TONKO2>>(0x2::coin::mint<TONKO2>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TONKO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONKO2>(arg0, 0, b"Tonkotsu ramen", b"TONKO2", b"The broth for tonkotsu ramen is based on pork bones, which is what the word tonkotsu means in Japanese.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https//i.ibb.co/Q3dkgfDz/tonkotsu.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONKO2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONKO2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

