module 0xc2e21e6ae72c47362b5867e369564af91783305c98cc8372a94ac48e6bd8e2ad::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"God of Sui", x"426f7720746f207468652024474f44206f66205375692e2054686520756c74696d6174652072756c6572206f662074686520537569204e6574776f726b2e20416c6c206861696c2074686520646976696e652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_1a40481af4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

