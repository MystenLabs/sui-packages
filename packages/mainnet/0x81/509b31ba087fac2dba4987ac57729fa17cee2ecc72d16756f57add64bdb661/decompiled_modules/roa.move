module 0x81509b31ba087fac2dba4987ac57729fa17cee2ecc72d16756f57add64bdb661::roa {
    struct ROA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROA>(arg0, 9, b"ROA", b"ROAD ", b"The new way to future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35abefef-7c91-4324-9e06-dd67d60b5082.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROA>>(v1);
    }

    // decompiled from Move bytecode v6
}

