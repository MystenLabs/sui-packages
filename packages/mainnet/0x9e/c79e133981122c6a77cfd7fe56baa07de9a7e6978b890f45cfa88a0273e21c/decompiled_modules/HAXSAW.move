module 0x9ec79e133981122c6a77cfd7fe56baa07de9a7e6978b890f45cfa88a0273e21c::HAXSAW {
    struct HAXSAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAXSAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAXSAW>(arg0, 9, b"haxsaw", b"HAXSAW", b"haxsaw", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HAXSAW>>(0x2::coin::mint<HAXSAW>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAXSAW>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAXSAW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

