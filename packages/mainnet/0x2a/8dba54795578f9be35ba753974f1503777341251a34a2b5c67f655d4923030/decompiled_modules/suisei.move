module 0x2a8dba54795578f9be35ba753974f1503777341251a34a2b5c67f655d4923030::suisei {
    struct SUISEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEI>(arg0, 6, b"Suisei", b"Suisei Hoshi", b"Hoshimachi Suisei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4212_57e55e982a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

