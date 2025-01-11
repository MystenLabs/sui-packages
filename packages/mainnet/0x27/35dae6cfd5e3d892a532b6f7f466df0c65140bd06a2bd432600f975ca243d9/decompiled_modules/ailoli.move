module 0x2735dae6cfd5e3d892a532b6f7f466df0c65140bd06a2bd432600f975ca243d9::ailoli {
    struct AILOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AILOLI>(arg0, 9, b"AILOLI", b"LOLI", b"$AILOLI - is the key for the AI future | Language model", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmacTPqRAE5GEcSPd5oTz2b79PzyCuhdPCMBWkBk75rnMW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AILOLI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AILOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILOLI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

