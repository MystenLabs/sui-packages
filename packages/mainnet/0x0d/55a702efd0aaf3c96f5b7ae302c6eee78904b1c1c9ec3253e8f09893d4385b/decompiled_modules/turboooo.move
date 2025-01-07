module 0xd55a702efd0aaf3c96f5b7ae302c6eee78904b1c1c9ec3253e8f09893d4385b::turboooo {
    struct TURBOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOOOO>(arg0, 6, b"Turboooo", b"Turbo in sui", b"I'm first turbo going to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000126660_ccb74c7305.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

