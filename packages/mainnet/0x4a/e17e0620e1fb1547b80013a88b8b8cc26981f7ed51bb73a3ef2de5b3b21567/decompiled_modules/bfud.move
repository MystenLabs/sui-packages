module 0x4ae17e0620e1fb1547b80013a88b8b8cc26981f7ed51bb73a3ef2de5b3b21567::bfud {
    struct BFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFUD>(arg0, 6, b"BFUD", b"BABY FUD", x"424142592046554420200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8326222_f1a5a6f6b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

