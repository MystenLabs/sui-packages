module 0x2910d1c7bd93ff2e27d77a79d98ef72cc3b919d1d17cb2a82c87ed61b56d9d8d::rll {
    struct RLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLL>(arg0, 9, b"RLL", b"rally", b"Hero of hard ways", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42ba68b0-e0f9-4541-8719-f0ae432131d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

