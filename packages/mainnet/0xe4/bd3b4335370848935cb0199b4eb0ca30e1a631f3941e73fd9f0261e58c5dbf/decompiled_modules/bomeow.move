module 0xe4bd3b4335370848935cb0199b4eb0ca30e1a631f3941e73fd9f0261e58c5dbf::bomeow {
    struct BOMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMEOW>(arg0, 6, b"BoMeow", b"Baby BoMeow", b"$BOMEOW is a token that derives its value from  internet, memes, trends. Unlike traditional cryptocurrencies which often back by utilities and blockchain.$BOMEOW is derived by community interest and sentiment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/12313111_c86a344f7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

