module 0x74a103fe71005be98ae3ddfcb871363b35e3093bd04f1bb2163ef8c970105a12::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"LOVE", b"LOVE", b"LOVE EACH OTHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn4.vectorstock.com/i/1000x1000/34/78/love-text-icon-valentines-symbol-hipster-vector-18883478.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOVE>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

