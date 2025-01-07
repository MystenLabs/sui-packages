module 0x4cf2f915af6d4e0245eb806486d2f72d146aee28b9b6a5bef032cedaef14a396::abnd {
    struct ABND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABND>(arg0, 9, b"ABND", b"Abandoned", b"BUY MY COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9962f0e9-2c74-46d2-9cd2-2d3369abb43d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABND>>(v1);
    }

    // decompiled from Move bytecode v6
}

