module 0xaa93849c7f28edaa9f9c14de73dca94196b1cc75c7ab449fba09b852b65a411::pugg {
    struct PUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGG>(arg0, 9, b"PUGG", b"PuggyPower", b" Adorable, pug-powered finances.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/790ee9f8-5bbf-4d66-8894-de3b31d56441.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

