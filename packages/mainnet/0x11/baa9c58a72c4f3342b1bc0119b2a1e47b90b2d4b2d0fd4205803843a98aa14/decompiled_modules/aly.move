module 0x11baa9c58a72c4f3342b1bc0119b2a1e47b90b2d4b2d0fd4205803843a98aa14::aly {
    struct ALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALY>(arg0, 9, b"ALY", b"ALY", b"Official token of Aly the most beautiful girl in the planet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

