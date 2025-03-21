module 0xf5689ae07e28f4b34ca5be0788c44a3f605177f3ec29bc19276ec7275ed93823::doby {
    struct DOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBY>(arg0, 9, b"DOBY", b"Doby On Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmP8zFSHPUugkvZXdD5DK68tSLCR9RCaUzdsFpGpX2Y9Aq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOBY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

