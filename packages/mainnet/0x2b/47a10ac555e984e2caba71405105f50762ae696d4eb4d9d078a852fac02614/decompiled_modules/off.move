module 0x2b47a10ac555e984e2caba71405105f50762ae696d4eb4d9d078a852fac02614::off {
    struct OFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFF>(arg0, 9, b"OFF", b"Offline", b"Turn off your screen and interact with other humans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/770f2f5a-fec8-4283-b97c-ccd5497169e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

