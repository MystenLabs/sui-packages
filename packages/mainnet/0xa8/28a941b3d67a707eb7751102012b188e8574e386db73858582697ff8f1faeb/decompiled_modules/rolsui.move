module 0xa828a941b3d67a707eb7751102012b188e8574e386db73858582697ff8f1faeb::rolsui {
    struct ROLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLSUI>(arg0, 6, b"ROLSUI", b"ROLANDO SUIIII", b"SUIIIIIIIIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_jpeg_27603647c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

