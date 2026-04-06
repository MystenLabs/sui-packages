module 0x53cd484d6d9f564086b5ff7225bb113d7f519ce1f7f9b67cc5569e9727bed067::baby_orca {
    struct BABY_ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_ORCA>(arg0, 9, b"Baby Orca", b"Baby Orca", b"The Golden Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775506484531-65019ab2e6807fdc2531c9d6ccdaaa2b.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BABY_ORCA>>(0x2::coin::mint<BABY_ORCA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_ORCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_ORCA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

