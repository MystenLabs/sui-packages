module 0xf59e85e529acded4ee906602ad0ae4d19163ab2ee658e47e81d3a177947f6275::m007 {
    struct M007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M007>(arg0, 6, b"007     ", b"AGENT 007 ", b"AGENT 007 is the official mascot o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa.lol/B33LVB           ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M007>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M007>>(v1);
    }

    // decompiled from Move bytecode v6
}

