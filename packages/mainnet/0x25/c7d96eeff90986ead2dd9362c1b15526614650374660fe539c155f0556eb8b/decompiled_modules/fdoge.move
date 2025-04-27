module 0x25c7d96eeff90986ead2dd9362c1b15526614650374660fe539c155f0556eb8b::fdoge {
    struct FDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOGE>(arg0, 9, b"FDOGE", b"Flying Doge", b"NO PURPOSE, NO UTILITY JUST FOR FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6a82f1ae29bc5851f4422d84828e1efbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

