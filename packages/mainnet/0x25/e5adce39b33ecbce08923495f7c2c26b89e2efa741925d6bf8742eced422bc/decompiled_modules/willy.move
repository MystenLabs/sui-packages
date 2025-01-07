module 0x25e5adce39b33ecbce08923495f7c2c26b89e2efa741925d6bf8742eced422bc::willy {
    struct WILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLY>(arg0, 6, b"WILLY", b"WillyonSui", b"WILLY COMING TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/EAQ_0art8_400x400_1fa6fc7e4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

