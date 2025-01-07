module 0xdd527c547df7900a99849f80b332eba7eb47d2aa0b54fdd1f9b112f1468dc0d7::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 6, b"PESTO", b"Pesto Sui", b"As the internet continues to obsess over adorable baby pygmy hippo Moo Deng, a baby penguin named Pesto at an Australian aquarium, has also been gaining attention due to his unusually large size.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_20_26_32_0e7b569b5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

