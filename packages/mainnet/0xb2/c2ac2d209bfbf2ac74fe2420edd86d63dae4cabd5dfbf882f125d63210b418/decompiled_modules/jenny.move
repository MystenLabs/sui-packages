module 0xb2c2ac2d209bfbf2ac74fe2420edd86d63dae4cabd5dfbf882f125d63210b418::jenny {
    struct JENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENNY>(arg0, 9, b"JENNY", b"jennyha", b"Forfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e282ea9-3089-4377-a7ff-fd223e21bd71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

