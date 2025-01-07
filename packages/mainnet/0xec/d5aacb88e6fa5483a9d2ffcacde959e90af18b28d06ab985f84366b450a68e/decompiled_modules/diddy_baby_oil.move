module 0xecd5aacb88e6fa5483a9d2ffcacde959e90af18b28d06ab985f84366b450a68e::diddy_baby_oil {
    struct DIDDY_BABY_OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY_BABY_OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY_BABY_OIL>(arg0, 9, b"DIDDY BABY OIL", b"DIDDY BABY OIL", b"I'm Diddy and ya are my son. Call me Daddy mfers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5QQRKwnJsoy5MHbYvUe1zgtNUGhesQ5SErQvnAZgpump.png?size=lg&key=cb55de")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIDDY_BABY_OIL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY_BABY_OIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY_BABY_OIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

