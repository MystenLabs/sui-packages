module 0x562fba92cd93bbbf00bc7f0beb2c69586a215f50266c72fff8833c751b780f2d::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD>(arg0, 9, b"GOOD", b"Chiboy", b"I love sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b543840-1b6e-43c3-88dd-820544195c1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

