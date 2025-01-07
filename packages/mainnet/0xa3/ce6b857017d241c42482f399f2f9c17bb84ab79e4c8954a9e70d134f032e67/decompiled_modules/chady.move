module 0xa3ce6b857017d241c42482f399f2f9c17bb84ab79e4c8954a9e70d134f032e67::chady {
    struct CHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADY>(arg0, 6, b"CHADY", b"ChadyCoin", b"CHAD CHAD CHAD CHAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020816_32ae78beb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

