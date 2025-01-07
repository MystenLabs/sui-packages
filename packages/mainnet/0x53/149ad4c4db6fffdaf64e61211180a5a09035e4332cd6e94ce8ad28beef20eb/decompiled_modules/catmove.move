module 0x53149ad4c4db6fffdaf64e61211180a5a09035e4332cd6e94ce8ad28beef20eb::catmove {
    struct CATMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMOVE>(arg0, 6, b"CATMOVE", b"CATFISH MOVEPUMP", b"CATFISH THE ORIGINAL MEME CAT and FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B0_EB_3886_161_A_442_B_A5_DD_8697877_FFE_21_3918e19eeb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

