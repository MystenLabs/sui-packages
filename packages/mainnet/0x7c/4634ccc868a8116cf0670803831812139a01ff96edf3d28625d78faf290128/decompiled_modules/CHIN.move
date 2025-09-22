module 0x7c4634ccc868a8116cf0670803831812139a01ff96edf3d28625d78faf290128::CHIN {
    struct CHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIN>(arg0, 9, b"chinwag", b"CHIN", b"chingwag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758542285/sui_tokens/a6fj1at7m24rlrfdlmar.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIN>>(0x2::coin::mint<CHIN>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

