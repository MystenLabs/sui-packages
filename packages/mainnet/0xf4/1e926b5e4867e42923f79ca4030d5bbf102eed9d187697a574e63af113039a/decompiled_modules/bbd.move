module 0xf41e926b5e4867e42923f79ca4030d5bbf102eed9d187697a574e63af113039a::bbd {
    struct BBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBD>(arg0, 6, b"BBD", b"BBD", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBD>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBD>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

