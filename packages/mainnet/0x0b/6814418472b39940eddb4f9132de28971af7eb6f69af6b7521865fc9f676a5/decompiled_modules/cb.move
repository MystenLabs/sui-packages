module 0xb6814418472b39940eddb4f9132de28971af7eb6f69af6b7521865fc9f676a5::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 6, b"CB", b"CapyBara Token", b"Look at the world calmly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731762711219.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

