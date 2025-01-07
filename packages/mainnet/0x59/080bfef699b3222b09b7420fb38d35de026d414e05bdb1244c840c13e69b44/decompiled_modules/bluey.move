module 0x59080bfef699b3222b09b7420fb38d35de026d414e05bdb1244c840c13e69b44::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"Bluey", b"Bluey on sui", b"Cute dog , with a costume, name is Bluey, rhymes with sui. BYU IT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018148_09b1d2045b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

