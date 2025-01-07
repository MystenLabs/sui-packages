module 0xa3739b9c908e753f314a836f20b313d610fd0913469bcf43be2c9f6bc0b88200::sgame {
    struct SGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAME>(arg0, 6, b"SGAME", b"GAME BOY Sui", b"Gameboy Sui - Play classic retro games on the blockchain with Gameboy Sui. Relive nostalgia, powered by the SUI network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DA_Jc_jib_400x400_912e634b31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

