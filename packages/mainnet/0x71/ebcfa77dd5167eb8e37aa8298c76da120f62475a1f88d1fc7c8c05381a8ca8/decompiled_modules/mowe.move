module 0x71ebcfa77dd5167eb8e37aa8298c76da120f62475a1f88d1fc7c8c05381a8ca8::mowe {
    struct MOWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOWE>(arg0, 9, b"MOWE", b"meow", b"MOEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7046beef-3eea-4290-89aa-a01cd348f332.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

