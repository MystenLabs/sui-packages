module 0x284b60ccd37a95a2c8a7bacf4ad8651b70d8be0fec5436f8006e7b4e883778d5::ozo {
    struct OZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZO>(arg0, 9, b"OZO", b"OZO", x"546865206f6e6520616e64206f6e6c7920244f5a4f2c20746865207265737420617265206a7573742077616e6e616265732e2049276d206865726520746f20636c61696d206d792063726f776e2120f09f9191202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmZceeT5MghPxv4aU4XnN5KNNJpgqV4AmQzMGbvzHXagAV?img-width=800&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OZO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

