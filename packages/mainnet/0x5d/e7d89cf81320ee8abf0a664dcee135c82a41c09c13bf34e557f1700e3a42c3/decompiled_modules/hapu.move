module 0x5de7d89cf81320ee8abf0a664dcee135c82a41c09c13bf34e557f1700e3a42c3::hapu {
    struct HAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPU>(arg0, 6, b"HAPU", b"HAPU SUI", x"244841505520434f494e0a244841505520617265206b6e6f776e20666f7220746865697220696e74656c6c6967656e63652c0a7265736f7572636566756c6e6573732c20616e64206162696c69747920746f207468726976652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_03_16_27_9c1ba1b1af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

