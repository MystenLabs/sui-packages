module 0xa6ee1100d6d76eda1ed282cf3425152562f544ddfa70113fb7aab6b7f7cca6d3::sanml {
    struct SANML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANML>(arg0, 6, b"SANML", b"Sui Animals", x"6d656f77206d656f772073696465206d6f7665206173696465200a0a2453414e4d4c206973206f6e20746865207761792020726f6c6c696e6720666173742c20766962696e672068617264200a4e6f206272616b65732e204e6f2064656c6179732e204a7573742070757265206d6f6d656e74756d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250508_165033_ee40befb5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANML>>(v1);
    }

    // decompiled from Move bytecode v6
}

