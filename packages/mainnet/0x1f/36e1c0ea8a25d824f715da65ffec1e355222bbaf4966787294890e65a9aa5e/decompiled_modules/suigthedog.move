module 0x1f36e1c0ea8a25d824f715da65ffec1e355222bbaf4966787294890e65a9aa5e::suigthedog {
    struct SUIGTHEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGTHEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGTHEDOG>(arg0, 9, b"SUIG THE DOG", b"SUIGTHEDOG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761317912/sui_tokens/wxvyw6nc4jqorvuyjc2v.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIGTHEDOG>>(0x2::coin::mint<SUIGTHEDOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIGTHEDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGTHEDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

