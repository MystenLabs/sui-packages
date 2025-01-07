module 0x39ee11401d776f2c41b8b71fcd42f9e9cb4d25e3290ae9d184d3b299b48bf954::bells {
    struct BELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLS>(arg0, 6, b"BELLS", b"Bellscoin Sui", b"Its often said by normies that the first memecoin was Dogecoin, created in December 2013. But thats not the whole truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_139e7c8bdc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

