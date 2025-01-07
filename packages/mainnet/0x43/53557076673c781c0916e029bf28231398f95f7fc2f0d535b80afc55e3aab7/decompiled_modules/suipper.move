module 0x4353557076673c781c0916e029bf28231398f95f7fc2f0d535b80afc55e3aab7::suipper {
    struct SUIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPPER>(arg0, 0, b"$SUPP", b"SUIPPER", b"I'm tired of all the f**cking rugs, suipper no swipping!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPPER>>(v1);
        0x2::coin::mint_and_transfer<SUIPPER>(&mut v2, 210000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPPER>>(v2);
    }

    // decompiled from Move bytecode v6
}

