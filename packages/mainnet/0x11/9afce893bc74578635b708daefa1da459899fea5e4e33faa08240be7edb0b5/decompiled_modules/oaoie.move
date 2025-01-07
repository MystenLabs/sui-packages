module 0x119afce893bc74578635b708daefa1da459899fea5e4e33faa08240be7edb0b5::oaoie {
    struct OAOIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAOIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OAOIE>(arg0, 6, b"OAOIE", b"OAOIEE", b"OAOIE lets you execute onchain transactions using natural language. Describe your intent, and our AI-powered system translates it into precise smart contract ca", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_035946381_7bbec935d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAOIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OAOIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

