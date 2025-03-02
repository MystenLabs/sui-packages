module 0xa8b6c5d6d095751f78cdea83f64f4bdf62d3f3b6d814c4f11014e7df769497be::zack {
    struct ZACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACK>(arg0, 9, b"ZACK", b"ZackToken", b"A token for Zack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZACK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

