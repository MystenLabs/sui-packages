module 0xad34d5b1564efd1514bb69c6940e9b0baac609ec4d6acd4a095e98e0b453ecc::trl {
    struct TRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRL>(arg0, 9, b"TRL", b"Turtle", b"boooooring walking with him but maybe it is a ninja, who knows?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cf71ed2-c198-4fc1-92b5-d15b09bd3e25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

