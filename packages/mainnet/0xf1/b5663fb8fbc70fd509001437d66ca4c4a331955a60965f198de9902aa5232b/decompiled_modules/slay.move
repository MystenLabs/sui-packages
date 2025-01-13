module 0xf1b5663fb8fbc70fd509001437d66ca4c4a331955a60965f198de9902aa5232b::slay {
    struct SLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAY>(arg0, 6, b"SLAY", b"Sol Slayer", b"Sui warriors slaying rug demons, battling Sol chads and maxis, while defending Suiakusa, the meme capital of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_com_croplo_d2c74e17ea.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

