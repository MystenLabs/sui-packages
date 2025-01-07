module 0xbdcc133c419ea41cb6bed9b22b9c115edef406c2e861a661241ec76e621d79a1::frozen {
    struct FROZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROZEN>(arg0, 9, b"FROZEN", b"Frozen", b"Frozen city", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa4ddd0a-5125-4aa9-9fb3-64d1cccabbd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

