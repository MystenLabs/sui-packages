module 0x5d06f651816cd1342c04fc4631ff601d9967159c1a17640275f17f6629d05a89::barbaratoken {
    struct BARBARATOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARBARATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARBARATOKEN>(arg0, 9, b"BARBARATOKEN", b"BarbaraToken", b"custom token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARBARATOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARBARATOKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARBARATOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

