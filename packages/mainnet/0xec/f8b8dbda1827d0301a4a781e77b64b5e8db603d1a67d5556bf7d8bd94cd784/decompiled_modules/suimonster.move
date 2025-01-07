module 0xecf8b8dbda1827d0301a4a781e77b64b5e8db603d1a67d5556bf7d8bd94cd784::suimonster {
    struct SUIMONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONSTER>(arg0, 6, b"SUIMONSTER", b"SUI MONSTER", b"The most powerful meme token in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_07_at_15_30_21_e48f2a3a2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

