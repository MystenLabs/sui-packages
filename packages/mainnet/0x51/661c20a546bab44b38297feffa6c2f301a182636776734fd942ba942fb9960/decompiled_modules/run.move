module 0x51661c20a546bab44b38297feffa6c2f301a182636776734fd942ba942fb9960::run {
    struct RUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUN>(arg0, 9, b"run", b"run", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

