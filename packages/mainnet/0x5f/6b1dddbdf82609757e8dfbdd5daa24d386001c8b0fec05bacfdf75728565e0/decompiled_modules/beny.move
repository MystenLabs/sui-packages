module 0x5f6b1dddbdf82609757e8dfbdd5daa24d386001c8b0fec05bacfdf75728565e0::beny {
    struct BENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENY>(arg0, 6, b"BENY", b"SUI BENY", b"HOLY BENY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/beny_3322558467.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENY>>(v1);
    }

    // decompiled from Move bytecode v6
}

