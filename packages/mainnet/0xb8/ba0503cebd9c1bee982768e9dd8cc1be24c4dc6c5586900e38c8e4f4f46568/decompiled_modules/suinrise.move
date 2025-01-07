module 0xb8ba0503cebd9c1bee982768e9dd8cc1be24c4dc6c5586900e38c8e4f4f46568::suinrise {
    struct SUINRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINRISE>(arg0, 6, b"SUINRISE", b"SUInrise", b"GM on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sunset_a64b91786c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

