module 0xe3481bc51e8ded6188eb94ba5403e8607c8189428e1bf3e75914610cb57ed978::qgh {
    struct QGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGH>(arg0, 9, b"Qgh", b"artjh", b"tyjhdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fbf73a5306bc91bd0aa2c4eff580fbfbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

