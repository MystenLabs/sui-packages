module 0xd7eef54dc73dd245a39b4b9daedc21bb34f5990d2e018589c1a45b9122b3ad09::gogoji {
    struct GOGOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGOJI>(arg0, 9, b"GOGOJI", b"GOGO", b"Muje testnet mila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6821c05a-15d6-4c04-9e83-d939b362044d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

