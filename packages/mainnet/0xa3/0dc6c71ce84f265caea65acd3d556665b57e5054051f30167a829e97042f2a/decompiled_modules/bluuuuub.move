module 0xa30dc6c71ce84f265caea65acd3d556665b57e5054051f30167a829e97042f2a::bluuuuub {
    struct BLUUUUUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUUUUUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUUUUUB>(arg0, 6, b"BLUUUUUB", b"BLUUUB", b"BLUUUUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_276a39715f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUUUUUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUUUUUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

