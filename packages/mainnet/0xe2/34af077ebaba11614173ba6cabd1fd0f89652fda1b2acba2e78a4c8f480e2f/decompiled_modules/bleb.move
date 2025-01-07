module 0xe234af077ebaba11614173ba6cabd1fd0f89652fda1b2acba2e78a4c8f480e2f::bleb {
    struct BLEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEB>(arg0, 6, b"BLEB", b"BLEB on SUI", b"Bleb, the surfer waterdrop, here to make waves. :>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kk_616a617dfe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

