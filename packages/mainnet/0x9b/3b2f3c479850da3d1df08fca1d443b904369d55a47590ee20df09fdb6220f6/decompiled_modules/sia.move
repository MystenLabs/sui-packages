module 0x9b3b2f3c479850da3d1df08fca1d443b904369d55a47590ee20df09fdb6220f6::sia {
    struct SIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIA>(arg0, 9, b"SIA", b"Sia", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/340/911/large/dave-theisen-sia-closeup-001.jpg?1727308453")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIA>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

