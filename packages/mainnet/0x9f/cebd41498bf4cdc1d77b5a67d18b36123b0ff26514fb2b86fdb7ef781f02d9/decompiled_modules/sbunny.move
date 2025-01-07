module 0x9fcebd41498bf4cdc1d77b5a67d18b36123b0ff26514fb2b86fdb7ef781f02d9::sbunny {
    struct SBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUNNY>(arg0, 5, b"SBUNNY", b"Slot Bunny", b"Slot Bunny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JYH3quf.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBUNNY>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUNNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

