module 0xcbd143fcd9cfea4f314a85177ac523644c5550c2f97b66acd4e9bfbf8a58a9c6::ghjdk {
    struct GHJDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHJDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHJDK>(arg0, 9, b"GHJDK", b"Quangman", x"5564696469646a646ac49169", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a82246a2-e484-4311-a202-d646344c5e14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHJDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHJDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

