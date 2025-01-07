module 0xf6cbe1470d38715fc63e333b6e76e6b02a13f58e802a8ba701973c552570585e::suipro {
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

