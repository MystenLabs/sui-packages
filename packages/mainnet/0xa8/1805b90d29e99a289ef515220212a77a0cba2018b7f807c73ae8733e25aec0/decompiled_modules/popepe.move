module 0xa81805b90d29e99a289ef515220212a77a0cba2018b7f807c73ae8733e25aec0::popepe {
    struct POPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEPE>(arg0, 6, b"Popepe", b"POPEPE", x"50657065207468652046726f672074616b65732074686520686f6c7920736561742061732024504f504550452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/popepelogo_c0c5e32f32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

