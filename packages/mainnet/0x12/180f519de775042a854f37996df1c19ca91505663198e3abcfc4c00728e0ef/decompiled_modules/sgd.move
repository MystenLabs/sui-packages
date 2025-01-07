module 0x12180f519de775042a854f37996df1c19ca91505663198e3abcfc4c00728e0ef::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGD>(arg0, 6, b"SGD", b"Sui Glitch Duck", b"the first glitch duck on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/glitch_f7aeca49ed.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

