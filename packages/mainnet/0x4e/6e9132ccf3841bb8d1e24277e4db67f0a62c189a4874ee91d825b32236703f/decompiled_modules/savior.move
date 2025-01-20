module 0x4e6e9132ccf3841bb8d1e24277e4db67f0a62c189a4874ee91d825b32236703f::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 9, b"SAVIOR", b"SAVIOR Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/CxUvAxLanvp587AQVpFanK6tZXS9RRUVK6GqkoS3pump.png?size=lg&key=b1e624"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAVIOR>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAVIOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

