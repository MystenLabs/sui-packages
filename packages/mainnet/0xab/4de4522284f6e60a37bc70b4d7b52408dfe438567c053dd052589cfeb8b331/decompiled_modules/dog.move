module 0xab4de4522284f6e60a37bc70b4d7b52408dfe438567c053dd052589cfeb8b331::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"DOG by SuiAI", b"DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_17_e784bcd867.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

