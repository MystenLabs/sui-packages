module 0xefc7043c2afe2dbe688a82d81b41a86ebc870000a86944de11d1a4a364663132::my_first_memecoin {
    struct MY_FIRST_MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_FIRST_MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MY_FIRST_MEMECOIN>(arg0, 0, b"$SUIP", b"SUIPPER", b"I'm tired of all the f**cking rugs, suipper no swipping!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FIRST_MEMECOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_FIRST_MEMECOIN>>(0x2::coin::mint<MY_FIRST_MEMECOIN>(&mut v3, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_FIRST_MEMECOIN>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MY_FIRST_MEMECOIN>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

