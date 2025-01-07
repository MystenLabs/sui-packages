module 0x43b09ed1ba2199e7eb697e8921e67ff51f49964d63c895a731741252f6dc9b37::aaadodo {
    struct AAADODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADODO>(arg0, 6, b"AAADODO", b"AAADODO SUI", b"$AAADODO Thinking is what makes us rich in the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731222643882.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAADODO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADODO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

