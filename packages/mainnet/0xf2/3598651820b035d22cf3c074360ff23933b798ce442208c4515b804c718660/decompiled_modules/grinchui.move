module 0xf23598651820b035d22cf3c074360ff23933b798ce442208c4515b804c718660::grinchui {
    struct GRINCHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCHUI>(arg0, 6, b"GRINCHUI", b"Grinch on SUI", x"4752494e4348204d454d4520434f494e20284752494e4348290a4752494e43482069732061206d656d6520636f696e206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/40_EO_Uai_G_400x400_e60ff0cdcc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

