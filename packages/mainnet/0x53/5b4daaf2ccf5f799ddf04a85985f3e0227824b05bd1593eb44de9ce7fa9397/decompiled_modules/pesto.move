module 0x535b4daaf2ccf5f799ddf04a85985f3e0227824b05bd1593eb44de9ce7fa9397::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 6, b"PESTO", b"Pesto", b"As the internet continues to obsess over adorable baby pygmy hippo Moo Deng, a baby penguin named Pesto at an Australian aquarium, has also been gaining attention due to his unusually large size.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_20_26_32_eba9ed6b9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

