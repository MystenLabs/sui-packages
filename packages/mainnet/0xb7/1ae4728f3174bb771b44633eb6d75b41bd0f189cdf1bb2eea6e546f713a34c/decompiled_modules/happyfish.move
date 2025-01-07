module 0xb71ae4728f3174bb771b44633eb6d75b41bd0f189cdf1bb2eea6e546f713a34c::happyfish {
    struct HAPPYFISH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAPPYFISH>, arg1: 0x2::coin::Coin<HAPPYFISH>) {
        0x2::coin::burn<HAPPYFISH>(arg0, arg1);
    }

    fun init(arg0: HAPPYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYFISH>(arg0, 6, b"HAPPYFISH", b"Happy Fish", b"Happy Happy Happy~ Happy Happy Happy Happy~ This is the happy song~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i1.sndcdn.com/artworks-OYGbRJdV7y36c2yD-9nYTuQ-t500x500.jpg"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYFISH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYFISH>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAPPYFISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAPPYFISH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

