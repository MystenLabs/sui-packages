module 0x931ba6a6c2567dded8bc0436794eef4c3764892d2587be3bfdbc84353ed2729d::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"Cheems Dog", b"momo  pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTu0eVQsWBD6fAGknOXGUtQcwyiK_tpOLop6Db1VM82gTidQd18pEAQwR9SDme8X7z9Ho&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOMO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

