module 0xee15545ade0c04c6f27f39c4bb7b3f28590f58921990c9e8b89de1ce185f51e5::sldr {
    struct SLDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLDR>(arg0, 9, b"SLDR", b"SOLDIOR", b"SOLDIOR COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73ffb5af-3408-43cb-a0a5-e9fb693ec4b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

