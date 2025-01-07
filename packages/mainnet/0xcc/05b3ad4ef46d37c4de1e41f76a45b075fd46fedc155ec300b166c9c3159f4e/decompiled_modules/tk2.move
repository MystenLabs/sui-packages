module 0xcc05b3ad4ef46d37c4de1e41f76a45b075fd46fedc155ec300b166c9c3159f4e::tk2 {
    struct TK2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK2>(arg0, 6, b"TK2", b"testToken2", b"this is test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013225055_35e25a7d65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TK2>>(v1);
    }

    // decompiled from Move bytecode v6
}

