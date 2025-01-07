module 0x1a3ef0f1c4d3550e06357b555fb1f535f66ed0b10e6ce6cd7634ef119c059f8d::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 6, b"Dogesui", b"dogesui", x"52444f4720565320444f4745535549204649474854210a0a58203a2068747470733a2f2f782e636f6d2f692f636f6d6d756e69746965732f31383431393436343936353734363139383236", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7n_Zsm_G_Wc_a398a6c7b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

