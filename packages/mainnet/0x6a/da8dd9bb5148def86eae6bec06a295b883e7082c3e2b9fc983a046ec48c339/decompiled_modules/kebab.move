module 0x6ada8dd9bb5148def86eae6bec06a295b883e7082c3e2b9fc983a046ec48c339::kebab {
    struct KEBAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEBAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEBAB>(arg0, 6, b"KEBAB", b"Doner Kebab", b"Delicious kebab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_20014fba53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEBAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEBAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

