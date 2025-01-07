module 0x9bc7dcb00bbd72f7d2386172c22709192d5d7b24d488a6622510b954efc00714::suipro {
    struct SUIPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRO>(arg0, 6, b"SUIPRO", b"SUI PRO BET AI", b"The first pro sports betting AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1296_607cca22d3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

