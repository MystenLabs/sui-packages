module 0x415d02b203232729c9f4bcd3e163d9a9fbcbd0ff827b906c1402f24cc999c633::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 6, b"CRASH", b"crash on sui", b"crash out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crash_on_sol_c6320ededf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

