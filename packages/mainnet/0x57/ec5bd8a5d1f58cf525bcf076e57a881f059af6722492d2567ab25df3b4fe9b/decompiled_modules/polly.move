module 0x57ec5bd8a5d1f58cf525bcf076e57a881f059af6722492d2567ab25df3b4fe9b::polly {
    struct POLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLY>(arg0, 6, b"POLLY", b"Pollybear", b"Pollybear has arrived!  The newest & cuddliest memecoin on the Sui blockchain is here to steal hearts and grow  wallets!  Join the bear revolution today. Lets make $POLLY unstoppable!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_D11741327_105187_lisa_granshaw_AAEA_3_BA_7_DBD_0_2809_3_D75_A303123_C3_B8_F_59be4ee1ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

