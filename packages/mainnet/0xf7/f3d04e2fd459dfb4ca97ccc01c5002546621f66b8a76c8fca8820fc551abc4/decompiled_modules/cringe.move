module 0xf7f3d04e2fd459dfb4ca97ccc01c5002546621f66b8a76c8fca8820fc551abc4::cringe {
    struct CRINGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRINGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRINGE>(arg0, 6, b"Cringe", b"Cringe on Sui", b"Dramatic behaviour ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BA_4_CEA_6_D_D2_BE_4461_8236_2_E27_CD_1_A70_C0_178c6f5eae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRINGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRINGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

