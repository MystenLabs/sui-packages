module 0x9454e1a9e51e5446304a150dd76ae9a2818be2990ce51081e9c27e86aacc2252::fepe {
    struct FEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEPE>(arg0, 6, b"FEPE", b"Fat Pepe", b"Fat Pepe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5989924690409407531_dc73538c16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

