module 0x3d9efa7e3a563a4e996fb3535996b9114165dc391089d04c3cd1d3a0ab929480::basecamp {
    struct BASECAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASECAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASECAMP>(arg0, 9, b"BASECAMP", b"Let's go to Sui Basecamp", b"Let's go on a pilgrimage to Sui Basecamp!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/m1xV4s1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BASECAMP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASECAMP>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASECAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

