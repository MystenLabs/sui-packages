module 0x288bd7121a7315edb4e721d62b200baf37760e3e918b3630dc79e221dc905292::pefu {
    struct PEFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEFU>(arg0, 9, b"PEFU", b"PEFU", b"PEFU", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEFU>(&mut v2, 22222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEFU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

