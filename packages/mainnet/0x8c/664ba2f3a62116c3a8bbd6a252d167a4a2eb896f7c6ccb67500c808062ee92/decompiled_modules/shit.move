module 0x8c664ba2f3a62116c3a8bbd6a252d167a4a2eb896f7c6ccb67500c808062ee92::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"SHIT", b"SHIT", b"SHIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/7pADAkcs3XgSYks26ttBED8JKdLrRhihyFGnCBs2pump.png?size=lg&key=8e1174"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

