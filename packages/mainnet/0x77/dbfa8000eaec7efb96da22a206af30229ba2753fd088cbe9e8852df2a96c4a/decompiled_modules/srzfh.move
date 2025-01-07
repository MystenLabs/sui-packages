module 0x77dbfa8000eaec7efb96da22a206af30229ba2753fd088cbe9e8852df2a96c4a::srzfh {
    struct SRZFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRZFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRZFH>(arg0, 9, b"srzfh", b"srzfh", b"kutdhhgfdhj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRZFH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRZFH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRZFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

