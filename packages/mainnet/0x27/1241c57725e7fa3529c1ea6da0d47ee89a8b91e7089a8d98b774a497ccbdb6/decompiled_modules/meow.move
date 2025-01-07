module 0x271241c57725e7fa3529c1ea6da0d47ee89a8b91e7089a8d98b774a497ccbdb6::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 9, b"MEOW", b"MEOW", b"MEOW memecoin fair launch on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tajukkelana.com/wp-content/uploads/2021/09/gambar-kucing-kartun-berwarna-1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEOW>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

