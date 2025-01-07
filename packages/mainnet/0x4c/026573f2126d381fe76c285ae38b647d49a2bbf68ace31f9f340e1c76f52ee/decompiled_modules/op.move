module 0x4c026573f2126d381fe76c285ae38b647d49a2bbf68ace31f9f340e1c76f52ee::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 6, b"Op", b"OPPAI", b"Oppai keeps bouncing in my wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727673475713_1_52c198316f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OP>>(v1);
    }

    // decompiled from Move bytecode v6
}

