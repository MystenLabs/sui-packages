module 0x4247f60734d68548d255d64700dd63da558a1e69d47aa47fae82c10a4f73419b::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 9, b"CAPY", b"https://x.com/capybaraonsui", b"capybaraonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1777846048519516160/6E1qOwBu_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

