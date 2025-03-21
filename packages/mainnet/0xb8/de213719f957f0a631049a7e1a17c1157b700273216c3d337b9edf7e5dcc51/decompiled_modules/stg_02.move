module 0xb8de213719f957f0a631049a7e1a17c1157b700273216c3d337b9edf7e5dcc51::stg_02 {
    struct STG_02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_02>(arg0, 6, b"STG_02", b"STG02", b"Egg is a decentralized meme coin that pays homage to the viral Instagram egg of 2019, with an ambitious goal to flip Pepe as the reigning meme in the crypto space. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/solana/4ynyx6BzY2XGFgjjun9Cruj1bSRo8FLsAqNnPsW6jDsu.webp?1706641649790"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_02>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_02>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_02>>(v2);
    }

    // decompiled from Move bytecode v6
}

