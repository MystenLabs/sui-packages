module 0x14aa39f995b6662c9da3b27e75aaa963b0a97807f07a68a95e3acaea158202dd::nautica {
    struct NAUTICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAUTICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAUTICA>(arg0, 9, b"NAUTICA", b"Suinautica", b"Sui Deep Blue Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1088850628040785920/d2UQkgAF_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAUTICA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAUTICA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAUTICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

