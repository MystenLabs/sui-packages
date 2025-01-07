module 0x3364f1fbf3b5d49663ee673c1e181b61364b3ecb7d506b21714c847df80872d4::tk1 {
    struct TK1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK1>(arg0, 6, b"TK1", b"testToken1", b"this is test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013225055_91c85c8449.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TK1>>(v1);
    }

    // decompiled from Move bytecode v6
}

