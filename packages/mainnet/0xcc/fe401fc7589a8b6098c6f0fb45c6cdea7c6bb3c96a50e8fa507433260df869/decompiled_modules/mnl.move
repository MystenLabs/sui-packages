module 0xccfe401fc7589a8b6098c6f0fb45c6cdea7c6bb3c96a50e8fa507433260df869::mnl {
    struct MNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNL>(arg0, 6, b"MnL", b"MONKEY AND ELEPHANT", b"Join the hilarious journey of the Monkey and the Elephant to the moon, all backed and supported by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736906883207.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

