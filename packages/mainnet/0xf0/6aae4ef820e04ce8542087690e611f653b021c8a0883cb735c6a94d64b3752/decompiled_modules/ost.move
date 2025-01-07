module 0xf06aae4ef820e04ce8542087690e611f653b021c8a0883cb735c6a94d64b3752::ost {
    struct OST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OST>(arg0, 6, b"OST", b"old school trump", b"A tribute for the man beloved on crypto market, not changing only the US but the whole world economic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_95a1a9bc06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OST>>(v1);
    }

    // decompiled from Move bytecode v6
}

