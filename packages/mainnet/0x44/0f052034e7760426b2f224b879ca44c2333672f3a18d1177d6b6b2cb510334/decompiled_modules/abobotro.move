module 0x440f052034e7760426b2f224b879ca44c2333672f3a18d1177d6b6b2cb510334::abobotro {
    struct ABOBOTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABOBOTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABOBOTRO>(arg0, 6, b"ABOBOTRO", b"ABOBOTROO", b"ABOBOTRO ARRIVED AT MOVEP NOW!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_191233940_1953547e69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABOBOTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABOBOTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

