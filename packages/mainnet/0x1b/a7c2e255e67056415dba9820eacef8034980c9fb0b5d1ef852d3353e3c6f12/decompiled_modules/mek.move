module 0x1ba7c2e255e67056415dba9820eacef8034980c9fb0b5d1ef852d3353e3c6f12::mek {
    struct MEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEK>(arg0, 9, b"MEK", b"MEKY", b"the coolest and shiny memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f598756d-d116-4ace-a6f8-021a018e8827.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

