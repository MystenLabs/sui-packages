module 0xacf54896000818f762fbf2ad85eaa62d65d5f7e097887d928b584d38dd29acf5::bmb {
    struct BMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMB>(arg0, 9, b"BMB", b"Bambi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse1.mm.bing.net/th?id=OIP.iGT9EKESjS1qpAAC46hC8QHaHr&pid=Api&P=0&h=180")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BMB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

