module 0x9696d17de9e39ee25b539858bd3c7a4ca5c77c2023500b7d8ec2c831b1d9298::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"Boss", b"TurBoss", b"Unofficial http://Turbos.fun Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731430879689.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

