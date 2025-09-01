module 0xbead400b5b4826835b6707ec939eeebf0c6ade7201417ea748672e7cece732b2::iii {
    struct III has drop {
        dummy_field: bool,
    }

    fun init(arg0: III, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<III>(arg0, 6, b"III", b"III", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<III>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<III>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<III>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

