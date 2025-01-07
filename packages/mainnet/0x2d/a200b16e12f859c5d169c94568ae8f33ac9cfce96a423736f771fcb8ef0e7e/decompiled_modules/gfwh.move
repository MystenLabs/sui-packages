module 0x2da200b16e12f859c5d169c94568ae8f33ac9cfce96a423736f771fcb8ef0e7e::gfwh {
    struct GFWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFWH>(arg0, 9, b"GFWH", b"Gold Fish With Hat", b"Your Crypto Gold Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GFWH>(&mut v2, 7000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFWH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

