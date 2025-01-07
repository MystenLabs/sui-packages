module 0xf6582a434a4427b61501a9de2a03d84534d3b0668d1616e09c3bc3740bb7e0f9::faker {
    struct FAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKER>(arg0, 9, b"FAKER", b"KINGFAKER", b"The 5th Demon King Championship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24ddaa0a-880c-44e2-97f2-acf9e04df71e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

