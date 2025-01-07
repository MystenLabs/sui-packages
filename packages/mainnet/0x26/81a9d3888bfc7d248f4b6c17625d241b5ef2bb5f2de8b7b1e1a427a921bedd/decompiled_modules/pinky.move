module 0x2681a9d3888bfc7d248f4b6c17625d241b5ef2bb5f2de8b7b1e1a427a921bedd::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 9, b"PINKY", b"pineapple Pinky", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F353fbd7f_7c9f_4de0_aa69_f37450ee149b_f8e2254369.jfif&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

