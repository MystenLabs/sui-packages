module 0x5004dcb025e912bd82d6e1b2ce67d5eb769e8cf37b01bc67f3267838a5d8bc11::catf {
    struct CATF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATF>(arg0, 6, b"CATF", b"CATF", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATF>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATF>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

