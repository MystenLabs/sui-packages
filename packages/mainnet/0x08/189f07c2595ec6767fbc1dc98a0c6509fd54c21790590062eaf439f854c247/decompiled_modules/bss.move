module 0x8189f07c2595ec6767fbc1dc98a0c6509fd54c21790590062eaf439f854c247::bss {
    struct BSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSS>(arg0, 6, b"BSS", b"Bad Santa on SUI", x"57652061726520726561647920666f7220584d4153200a4974277320696e206f7572207469636b657220244253530a0a49545320494e204f555220444e41", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_Q_Bq_Ua_P5_400x400_ab665f83ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

