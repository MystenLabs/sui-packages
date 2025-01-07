module 0x2430da3ee0ea861eef9e55e3798d38c0896e5b4e3ac2fc6cbd1867f5414cd8c9::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"Suimp", b"Sui Trump", b"Love him or hate him, Sui Trump is making moves on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimp_0f5894ad9c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

