module 0x457f341b7439037b8b434d7fe9f0dd3e2ce1bfc0388ec8fdefcbb7375eeafddf::bnz {
    struct BNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNZ>(arg0, 6, b"BNZ", b"Bonez", b"BNZ - real token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753145067249.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

