module 0x33a1c0cc05fe50a6c8ef4a72af749cf69d82f68ce1e55adb6d78459908627f36::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 9, b"KM", b"kapakmerah", b"Little community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/883da51e-722b-4c52-8ded-924b98854f40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KM>>(v1);
    }

    // decompiled from Move bytecode v6
}

