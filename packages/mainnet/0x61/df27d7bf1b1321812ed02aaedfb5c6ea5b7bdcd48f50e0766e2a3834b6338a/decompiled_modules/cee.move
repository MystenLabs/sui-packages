module 0x61df27d7bf1b1321812ed02aaedfb5c6ea5b7bdcd48f50e0766e2a3834b6338a::cee {
    struct CEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEE>(arg0, 9, b"CEE", b"CENTRAL CEE", b"Dude stay here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://content.beatstars.com/users/prod/719404/image/9ziVNu78DxFK/screenshot20211125at200522.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CEE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

