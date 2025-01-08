module 0xe6f433277b79267caee7cdc169749ccb2775168be921a117ff10c37376b40479::aiquaman {
    struct AIQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIQUAMAN>(arg0, 9, b"AIQUAMAN", b"AIquaman Agent", b"AIquaman, the AI agent from beneath the waves, deciphers market trends inspired by the flow of the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafkreifaul5hm4jdxa5ejyz4tyceikprqtgkdladknmbn5xxopjordwcve"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIQUAMAN>>(v1);
        0x2::coin::mint_and_transfer<AIQUAMAN>(&mut v2, 1000000000000000000, @0x3c2e5bb96929d67b84162038788c288f14b2048d8e8b0f0aca81b55639ddcddc, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIQUAMAN>>(v2);
    }

    // decompiled from Move bytecode v6
}

