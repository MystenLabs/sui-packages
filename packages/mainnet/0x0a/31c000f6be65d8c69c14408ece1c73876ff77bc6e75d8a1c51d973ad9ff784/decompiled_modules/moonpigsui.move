module 0xa31c000f6be65d8c69c14408ece1c73876ff77bc6e75d8a1c51d973ad9ff784::moonpigsui {
    struct MOONPIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPIGSUI>(arg0, 6, b"MOONPIGSUI", b"MOONPIG ON SUI", b"Moonpig on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiataphbgkjrbot3woon4zdb7w2dthxwajdgnh6vvaykk53eutaojm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONPIGSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

