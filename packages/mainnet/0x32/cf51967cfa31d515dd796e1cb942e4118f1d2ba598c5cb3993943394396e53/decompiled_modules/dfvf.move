module 0x32cf51967cfa31d515dd796e1cb942e4118f1d2ba598c5cb3993943394396e53::dfvf {
    struct DFVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFVF>(arg0, 9, b"dfvf", b"dfvf", b"dsvc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DFVF>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFVF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFVF>>(v1);
    }

    // decompiled from Move bytecode v6
}

