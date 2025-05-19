module 0x91b91d1d99a0397b242fde7a713aefd79605bb2486b1fd700708a2c91c777407::suibase {
    struct SUIBASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASE>(arg0, 6, b"SUIBASE", b"Sui Base", b"THE GATEWAY TO MARS BY SUIX AEROSPACE, FOUNDED BY  MYSTEN LABS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxjeewnmpett7kz5ptpscjgbl7zxbznag4vkfiiaitxx2xkewzja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBASE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

