module 0x78a00e334fc0a9db8f3b8e974aa8f29763370c284ed9a0ba62dbbbc58f9ee93d::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAT>(arg0, 9, b"RAT", b"RAT", b"First RAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6nt5LCBRv8UWvCVnLmNH1amtTxRyVHeBbBQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

