module 0x68ae3bc05aa1e531d9a81ebef78839298f2fb5b86de905a9aaf1d17904cb938::kata {
    struct KATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATA>(arg0, 9, b"kata", b"kata", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KATA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

