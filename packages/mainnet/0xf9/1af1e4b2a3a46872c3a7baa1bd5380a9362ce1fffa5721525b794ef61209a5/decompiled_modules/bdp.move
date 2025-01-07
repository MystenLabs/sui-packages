module 0xf91af1e4b2a3a46872c3a7baa1bd5380a9362ce1fffa5721525b794ef61209a5::bdp {
    struct BDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDP>(arg0, 6, b"BDP", b"Balls Deep", b"Balls deep.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953032547.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

