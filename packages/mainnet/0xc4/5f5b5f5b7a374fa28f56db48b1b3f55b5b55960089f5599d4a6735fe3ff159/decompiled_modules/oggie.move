module 0xc45f5b5f5b7a374fa28f56db48b1b3f55b5b55960089f5599d4a6735fe3ff159::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 6, b"Oggie", b"Oggie On Sui", b"Oggie is a silly Pepe for the silliest of goobers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z6047612145962_3bebbdc8be2f4079d1abc6484f31bc4a_20241119061351_g7gi_9b19c87bd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

