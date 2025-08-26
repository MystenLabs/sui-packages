module 0x971c94c7f2081d7f461515ac5c6334599066e60db8d712dc358fa57dc7e8b295::Letter_R {
    struct LETTER_R has drop {
        dummy_field: bool,
    }

    fun init(arg0: LETTER_R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LETTER_R>(arg0, 9, b"RRR", b"Letter R", b"the letter r i here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1885072722771763200/GJ3AjASv_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LETTER_R>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LETTER_R>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

