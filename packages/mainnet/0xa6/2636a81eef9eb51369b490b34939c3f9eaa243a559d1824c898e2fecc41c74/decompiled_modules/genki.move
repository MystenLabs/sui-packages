module 0xa62636a81eef9eb51369b490b34939c3f9eaa243a559d1824c898e2fecc41c74::genki {
    struct GENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENKI>(arg0, 6, b"GENKI", b"Genki", b"THE REAL GENKI ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/genki_ebecb108b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

