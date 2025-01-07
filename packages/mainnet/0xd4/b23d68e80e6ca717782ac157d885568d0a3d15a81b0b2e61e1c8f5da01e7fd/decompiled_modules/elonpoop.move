module 0xd4b23d68e80e6ca717782ac157d885568d0a3d15a81b0b2e61e1c8f5da01e7fd::elonpoop {
    struct ELONPOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONPOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONPOOP>(arg0, 6, b"ElonPoop", b"Elon Musk Poop", x"41206d656d6520776865726520456c6f6e204d75736b20506f6f7020f09f92a9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731458166170.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONPOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONPOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

