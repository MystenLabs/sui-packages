module 0x5a935f92ff16ce93ee7d949454802a112239dcc991bae60eba1a52ef0c4628eb::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"GAY", b"IF YOU SELL YOU GAY", b"If you sell you gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_02_T002754_662_b472de853a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

