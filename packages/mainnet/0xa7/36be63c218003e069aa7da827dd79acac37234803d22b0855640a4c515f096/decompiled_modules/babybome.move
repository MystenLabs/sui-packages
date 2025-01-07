module 0xa736be63c218003e069aa7da827dd79acac37234803d22b0855640a4c515f096::babybome {
    struct BABYBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBOME>(arg0, 6, b"BABYBOME", b"BABY BOME", b"The Book of Baby Memes on SUI.The largest exchange Binance is preparing for it! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ztik_Fx_Xo_Ao_Rak_T_eab394d17c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

