module 0xb47fcca2d86dbead825ec98c89b2fcdd282e1cfd601937c2e55b38a7be25b41b::cocacola {
    struct COCACOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCACOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCACOLA>(arg0, 6, b"COCACOLA", b"Sui CocaCola", b"The classic fizz with a Sui twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coca_Cola_f608652a85.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCACOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCACOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

