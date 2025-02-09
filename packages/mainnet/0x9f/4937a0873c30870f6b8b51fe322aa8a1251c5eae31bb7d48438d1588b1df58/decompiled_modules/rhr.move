module 0x9f4937a0873c30870f6b8b51fe322aa8a1251c5eae31bb7d48438d1588b1df58::rhr {
    struct RHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHR>(arg0, 9, b"RHR", b"Richhamste", b"New memcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cb3d0c3-e70f-4948-a64e-42ec12354a65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

