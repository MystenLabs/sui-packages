module 0x1c78b2028c785efe7448a593487649b8d3376df9a15b291813fa329fc56e4472::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"FROG", b"Talus Memefrog", b"The frog you've all been waiting for", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/918d82b9393c8c73b5c3ee8c1917b90ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

