module 0xfdba35bc1afc68e601b06f0849954e07c790f88062ffeeaba6d2c9df01747f08::loaf {
    struct LOAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOAF>(arg0, 6, b"LOAF", b"SUILOAF", b"THE ONLY COIN U KNEAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V_Pow_AU_400x400_710b4f221d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

