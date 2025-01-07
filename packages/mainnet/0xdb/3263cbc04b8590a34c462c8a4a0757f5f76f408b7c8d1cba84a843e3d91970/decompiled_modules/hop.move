module 0xdb3263cbc04b8590a34c462c8a4a0757f5f76f408b7c8d1cba84a843e3d91970::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"HIP-HOP", x"4c61756e6368696e67206f6e20535549206e6574776f726b2c20666f6c6c6f77696e6720746865206d657461206f6620484f502e66756e206c61756e6368696e6720736f6f6e2121210a68747470733a2f2f742e6d652f686970686f70737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_36_1c108c0a3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

