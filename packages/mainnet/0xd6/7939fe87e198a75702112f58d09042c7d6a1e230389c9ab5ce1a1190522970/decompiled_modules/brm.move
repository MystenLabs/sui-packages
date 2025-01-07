module 0xd67939fe87e198a75702112f58d09042c7d6a1e230389c9ab5ce1a1190522970::brm {
    struct BRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRM>(arg0, 9, b"BRM", b"bringtome", b"ohyeee to me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/631d4eff-2ace-4251-bd42-8ed053101987.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

