module 0xd44a8e28b65a9d42378ff229c69692a1ce903e74a10a2e0434535b0260c7f87f::suidrake {
    struct SUIDRAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRAKE>(arg0, 6, b"SuiDrake", b"Sui Drake", b"Sui Drake Live From The 6 Live on Sui!  Lets run it back Fam!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_drake_rough_9503cdbba0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

