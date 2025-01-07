module 0xc5cf4890adf3639d9f7a69b83be41950698720781aab12d97d45d26aff7e8e27::zoro {
    struct ZORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORO>(arg0, 9, b"Zoro", b"ZoroCoin", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzSpVJN-E0yz3HmCFyCxdOSX0m35SDLU-KCw&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZORO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

