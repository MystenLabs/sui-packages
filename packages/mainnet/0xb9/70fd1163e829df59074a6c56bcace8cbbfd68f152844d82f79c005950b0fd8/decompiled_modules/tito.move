module 0xb970fd1163e829df59074a6c56bcace8cbbfd68f152844d82f79c005950b0fd8::tito {
    struct TITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITO>(arg0, 6, b"Tito", b"Tito General", b"General of Jugoslavia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005147_02a451690a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

