module 0x7e2e0d82e935ce5e782d523de56ba2ce6fd053040258123928b3e4a39aea0814::qgh {
    struct QGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGH>(arg0, 9, b"Qgh", b"jetyjrwh", b"tyyjhdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/57c709eb6ecd9f04b211faab3f29a6acblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

