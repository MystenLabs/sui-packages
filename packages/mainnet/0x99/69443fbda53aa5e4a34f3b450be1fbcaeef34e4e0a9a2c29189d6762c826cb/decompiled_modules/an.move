module 0x9969443fbda53aa5e4a34f3b450be1fbcaeef34e4e0a9a2c29189d6762c826cb::an {
    struct AN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AN>(arg0, 9, b"AN", b"Vu", b"Babydog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2afdd4c3-6885-4077-afe8-55a689c78dde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AN>>(v1);
    }

    // decompiled from Move bytecode v6
}

