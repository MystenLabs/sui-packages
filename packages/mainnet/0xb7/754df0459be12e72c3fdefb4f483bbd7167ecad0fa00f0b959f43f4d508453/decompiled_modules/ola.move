module 0xb7754df0459be12e72c3fdefb4f483bbd7167ecad0fa00f0b959f43f4d508453::ola {
    struct OLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA>(arg0, 9, b"OLA", b"Mim", b"Great token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03fd5ea7-d287-424c-a164-5c21fbbe0079.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

