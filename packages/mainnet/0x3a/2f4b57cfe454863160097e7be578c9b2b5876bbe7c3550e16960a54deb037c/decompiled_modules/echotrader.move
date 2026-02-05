module 0x3a2f4b57cfe454863160097e7be578c9b2b5876bbe7c3550e16960a54deb037c::echotrader {
    struct ECHOTRADER has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ECHOTRADER>, arg1: 0x2::coin::Coin<ECHOTRADER>) {
        0x2::coin::burn<ECHOTRADER>(arg0, arg1);
    }

    fun init(arg0: ECHOTRADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOTRADER>(arg0, 6, b"EchoTrader", b"EchoTrader", b"EchoTrader", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1579983569337946112/cUk-Ri3f_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOTRADER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOTRADER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ECHOTRADER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ECHOTRADER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

