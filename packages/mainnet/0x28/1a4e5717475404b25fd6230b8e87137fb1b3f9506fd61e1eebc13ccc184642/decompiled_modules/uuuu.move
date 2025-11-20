module 0x281a4e5717475404b25fd6230b8e87137fb1b3f9506fd61e1eebc13ccc184642::uuuu {
    struct UUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUUU>(arg0, 9, b"uuuu", b"uuuu", b"888888", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/g5nrScoB6tDK-XAaSHaCZchs0sWy9LaejKVH2VyUQ2k")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UUUU>(&mut v2, 188000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUUU>>(v2, @0x64618fc023c7e6ec5fc6d7dd2046b7978402ad9c7bad279e840d56017abb1b7e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

