module 0x54762c07249966dd7c6a5d99c4fe6fa95bed5250dc4dbbbe2cb86a79f36c48b::owke {
    struct OWKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKE>(arg0, 9, b"OWKE", b"hejd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3c4a4a6-8b18-4f70-af17-c4eb97ce8670.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

