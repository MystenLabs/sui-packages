module 0xb10eb67729bbf54aee82e7df4cb2e7587438d29fa6b604c68e6ca4e3e44d4925::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL>(arg0, 6, b"AL", b"AlexStore", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748012730002.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

