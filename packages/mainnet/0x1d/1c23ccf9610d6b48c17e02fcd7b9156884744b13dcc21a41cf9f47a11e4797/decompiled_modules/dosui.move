module 0x1d1c23ccf9610d6b48c17e02fcd7b9156884744b13dcc21a41cf9f47a11e4797::dosui {
    struct DOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSUI>(arg0, 6, b"DOSUI", b"DoraeSUI", b"AS THE LATEST MEME TOKEN, $DORAE IS FULL OF FUN AND ENDLESS POTENTIAL. JOIN US IN BRINGING WARMTH AND LIQUIDITY TO THE SUI CHAIN | https://www.doraesui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t09_d931699312.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

