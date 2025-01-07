module 0xac73196ca46813276125f0c1f8fb957436c91c980718ef06a94dbb281a4dc45d::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 9, b"ETH", b"Ethereum", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://logowik.com/content/uploads/images/ethereum3649.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ETH>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

