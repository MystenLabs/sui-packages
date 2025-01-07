module 0xbd84477af8cf7e1d4b23d7a32cad7535f9e58ef186f69c9c7997ffb2bfc0ea1b::dogge {
    struct DOGGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGE>(arg0, 9, b"DOGGE", b"Doggewif", b"Doggewif fun, amazing newly created", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1392205620837822469/vp3-MxUV.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGGE>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

