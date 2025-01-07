module 0xd06278ad71b5a4d622f179bd21d163d2efc8aaf14e1750884026f63e3d07ca3a::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 6, b"SURF", b"SurfDog", b"good boi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.surfdog.xyz/SurfDog.png")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SURF>>(0x2::coin::mint<SURF>(&mut v3, 1000000000000000000, arg1), @0xcf2d85465d72cef66b9e50161d1c2fbf3b0fef4d51434d4f88163f7d288f7685);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURF>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v3, 0x2::object::id_address<0x2::coin::CoinMetadata<SURF>>(&v2));
    }

    // decompiled from Move bytecode v6
}

