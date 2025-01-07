module 0xf6deb2ce5ca58667df467e8f4c54cf7f7066583675ec643542ac5466f2587e0f::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 6, b"PUSSY", b"Pussycat", b" $PUSSY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Kc3_RAS_1_400x400_6396acf949.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

