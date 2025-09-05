module 0xa85fa4e6082315afc865b79201e39e60e555e2d07efefaa71f532a3d2a3b14e7::pepper {
    struct PEPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPER>(arg0, 6, b"PEPPER", b"HOT PEPPA", b"The spiciest memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4z2yvzt6iiko4ycmuvgucagvwe6d47p43cdcggtkrwliyb4ljse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

