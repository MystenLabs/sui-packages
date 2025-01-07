module 0xa9a3c67226edf0cd5190717b5253b6ab6e0fe42f760f22f40a52df03fa958ee8::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 9, b"DIDDY", b"DIDDY", b"I'm Diddy and ya are my son. Call me Daddy mfers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5QQRKwnJsoy5MHbYvUe1zgtNUGhesQ5SErQvnAZgpump.png?size=lg&key=cb55de")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIDDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

