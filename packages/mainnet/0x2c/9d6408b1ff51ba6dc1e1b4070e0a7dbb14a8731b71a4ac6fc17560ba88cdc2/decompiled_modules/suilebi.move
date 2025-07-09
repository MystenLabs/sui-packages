module 0x2c9d6408b1ff51ba6dc1e1b4070e0a7dbb14a8731b71a4ac6fc17560ba88cdc2::suilebi {
    struct SUILEBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEBI>(arg0, 9, b"SUIBI", b"Suilebi", b"A small, mystical sprite with leafy antennae, floating inside a glowing Sui bubble.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILEBI>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

