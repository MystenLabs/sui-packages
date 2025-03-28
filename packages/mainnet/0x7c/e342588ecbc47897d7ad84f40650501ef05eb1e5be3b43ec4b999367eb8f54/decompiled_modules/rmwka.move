module 0x7ce342588ecbc47897d7ad84f40650501ef05eb1e5be3b43ec4b999367eb8f54::rmwka {
    struct RMWKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMWKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMWKA>(arg0, 9, b"RMWKA", b"Romawka", b"ROMAWKAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eb86249e2ba0321ce3a9456a7fd07865blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMWKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMWKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

