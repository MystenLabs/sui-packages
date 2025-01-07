module 0xd0b20a02d3008b80d5f62508a46856b41e691c075dfce5dfca97087b902ed95b::salu {
    struct SALU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALU>(arg0, 9, b"SALU", b"sallu", b"SALU SALUSALU SALU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/284030c8-e302-4629-80f6-39a06ab3dd48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALU>>(v1);
    }

    // decompiled from Move bytecode v6
}

