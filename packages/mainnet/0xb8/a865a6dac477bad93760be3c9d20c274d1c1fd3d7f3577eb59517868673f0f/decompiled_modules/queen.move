module 0xb8a865a6dac477bad93760be3c9d20c274d1c1fd3d7f3577eb59517868673f0f::queen {
    struct QUEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEEN>(arg0, 1, b"QUEEN", b"QUEEN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUEEN>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

