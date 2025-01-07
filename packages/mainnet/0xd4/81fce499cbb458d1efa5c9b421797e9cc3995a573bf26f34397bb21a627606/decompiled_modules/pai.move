module 0xd481fce499cbb458d1efa5c9b421797e9cc3995a573bf26f34397bb21a627606::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"PAIN", b"Just PAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Stock_545646362_58e3f5b05f9b58ef7e137d92_5047fb1c26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

