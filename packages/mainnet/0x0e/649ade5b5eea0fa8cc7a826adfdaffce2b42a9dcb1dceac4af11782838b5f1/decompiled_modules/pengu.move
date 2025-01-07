module 0xe649ade5b5eea0fa8cc7a826adfdaffce2b42a9dcb1dceac4af11782838b5f1::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"PENGU", b"Spreading good vibes across the meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848765927451492364/VysuN6mu_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGU>>(0x2::coin::mint<PENGU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PENGU>>(v2);
    }

    // decompiled from Move bytecode v6
}

