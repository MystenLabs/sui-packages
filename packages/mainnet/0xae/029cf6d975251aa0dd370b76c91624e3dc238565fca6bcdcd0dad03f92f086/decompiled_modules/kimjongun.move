module 0xae029cf6d975251aa0dd370b76c91624e3dc238565fca6bcdcd0dad03f92f086::kimjongun {
    struct KIMJONGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMJONGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMJONGUN>(arg0, 9, b"KIMJONGUN", b"KIMJONGUN Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/TbDYECFcPHnG4fTwXwtEwxaa3vmRjpF8hYDAMG7pump.png?size=lg&key=045eea"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIMJONGUN>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMJONGUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMJONGUN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

