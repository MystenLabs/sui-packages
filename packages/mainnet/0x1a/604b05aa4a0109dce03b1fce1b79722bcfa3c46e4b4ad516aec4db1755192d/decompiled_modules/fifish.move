module 0x1a604b05aa4a0109dce03b1fce1b79722bcfa3c46e4b4ad516aec4db1755192d::fifish {
    struct FIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFISH>(arg0, 6, b"FIFISH", b"Fifish", b"I'm a fish and u? i'm a fish too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/19_dad87f5933.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

