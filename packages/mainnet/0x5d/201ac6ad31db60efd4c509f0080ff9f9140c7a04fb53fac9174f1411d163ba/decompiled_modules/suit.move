module 0x5d201ac6ad31db60efd4c509f0080ff9f9140c7a04fb53fac9174f1411d163ba::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 9, b"Doge Wif Suit", b"SUIT", b"https://dogewifsuit.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1841362119947870209/Uf067lmt_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

