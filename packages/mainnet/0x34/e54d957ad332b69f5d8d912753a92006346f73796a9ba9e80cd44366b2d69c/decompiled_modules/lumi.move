module 0x34e54d957ad332b69f5d8d912753a92006346f73796a9ba9e80cd44366b2d69c::lumi {
    struct LUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMI>(arg0, 9, b"LUMI", b"Lumina", b"it's just a miracle, poink (**)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma5GZu3u8Ci8K32YPfDXgr8t9gFGedbvrHPvva4fzbe8Y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

