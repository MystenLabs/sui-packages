module 0xa491e246f69df600fbbbd89a2eeaf1dd6aab12b30b34532b6968fdc239bb5576::jinping {
    struct JINPING has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINPING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINPING>(arg0, 9, b"JINPING", b"JINPING Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/GfeYVzB9aky3RSZ1KMAwp2XnYvkwjFufT3uqyeH8pump.png?size=lg&key=3f040a"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JINPING>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINPING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINPING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

