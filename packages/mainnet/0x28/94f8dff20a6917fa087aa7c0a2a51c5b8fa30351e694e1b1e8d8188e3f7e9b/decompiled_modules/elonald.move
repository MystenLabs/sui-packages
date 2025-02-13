module 0x2894f8dff20a6917fa087aa7c0a2a51c5b8fa30351e694e1b1e8d8188e3f7e9b::elonald {
    struct ELONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONALD>(arg0, 9, b"ELONALD", b"ELONALD ON SUI", b"My  Valentine ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRv13bsqoPGbTy8CTtRwT9mLCY7kXkZbzJBMycEEkDG1D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONALD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONALD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

