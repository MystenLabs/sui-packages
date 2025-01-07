module 0x6a1817202081f9aaab60ebaa040754fa105d550c77e91f59949d71c2859e07ec::cj {
    struct CJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJ>(arg0, 9, b"CJ", b"CJ", b"CJ Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CJ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

