module 0x7ff3f3de5030bf5823eb573511db30aa336684919674bb02e3164cd79b3ceeef::PINK {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 9, b"CAT", b"Pink Cat", b"Pink Cat Ruzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.artpal.com%2FtheArtChick%3Fi%3D287530-14&psig=AOvVaw0rgFC-UPF_-KhmjhsDAoBG&ust=1732214416905000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIj72NvH64kDFQAAAAAdAAAAABAJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

