module 0xf037f566f9494a548990389a8ecc7ada43a788a4bb5109d827bea0682117a8f1::bobls {
    struct BOBLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBLS>(arg0, 6, b"BOBLS", b"Bobls", b"Bobls - Octopus with sharp and deadly ink", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020176_03bccf4cf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

