module 0x613b71c3ceba112a86461208be9725f1d6aea6bf3a67ab14384d050f2112fbb6::grumpycat {
    struct GRUMPYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPYCAT>(arg0, 9, b"GRUMPYCAT", b"GrumpyCat", b"Grumpy Cat soared to fame and became a worldwide sensation in 2012 when her frowning face was shared on the internet. The first video of Grumpy Cat was shared on YouTube. With more than 1.5 million views in the first 36 hours.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/651aeb87-3c7f-4e38-b3bf-1befcb95dad4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMPYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

