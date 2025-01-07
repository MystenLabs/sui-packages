module 0xb44b1b50e7cad72653388da1e20a5bb410b401f1d68551311fefc7f88c48075::jmine {
    struct JMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMINE>(arg0, 9, b"JMINE", b"Jauwalmini", b"For birthday party celebrating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cbf9436-c629-457e-8916-374ad2bfc524.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

