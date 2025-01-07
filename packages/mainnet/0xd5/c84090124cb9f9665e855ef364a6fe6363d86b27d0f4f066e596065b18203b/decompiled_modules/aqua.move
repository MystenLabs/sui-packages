module 0xd5c84090124cb9f9665e855ef364a6fe6363d86b27d0f4f066e596065b18203b::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 8, b"AQUA", b"Aquarsui", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_6BE0shrhTMDU4MA0RN2JfeoJG73YT2fFnQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AQUA>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

