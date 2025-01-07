module 0x4df66b75822e999b73fa3f93408d932dbeaec6244bb320d52c4807c19d104660::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"TurBoss", b"Unofficial http://Turbo.fun Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731075580047.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

