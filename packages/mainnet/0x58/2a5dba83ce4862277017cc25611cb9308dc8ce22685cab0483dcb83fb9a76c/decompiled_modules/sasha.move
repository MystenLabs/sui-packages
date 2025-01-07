module 0x582a5dba83ce4862277017cc25611cb9308dc8ce22685cab0483dcb83fb9a76c::sasha {
    struct SASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHA>(arg0, 6, b"Sasha", b"Sasha The Cat", b"My purchase will be 100% burned. This will be a 100% community managed token, just like bitcoin did.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_03_04_48_943c0829b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

