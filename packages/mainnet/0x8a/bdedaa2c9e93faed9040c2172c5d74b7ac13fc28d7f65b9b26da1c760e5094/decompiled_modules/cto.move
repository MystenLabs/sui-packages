module 0x8abdedaa2c9e93faed9040c2172c5d74b7ac13fc28d7f65b9b26da1c760e5094::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 9, b"CTO", b"Community Take Over", b"CTO - the best meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc3WSL3F79wHdzjgKLe4jCDcbTQeoYEznAAg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTO>(&mut v2, 3333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

