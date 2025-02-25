module 0x46cdfa1e7871081fde81c0e1dad001dfd57b3096657606d03cac8e81426cf33b::rtest {
    struct RTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTEST>(arg0, 9, b"rtest", b"richard test", b"test otken for richard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RTEST>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

