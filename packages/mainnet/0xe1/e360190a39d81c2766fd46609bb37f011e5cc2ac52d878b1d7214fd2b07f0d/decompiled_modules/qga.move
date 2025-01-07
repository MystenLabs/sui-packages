module 0xe1e360190a39d81c2766fd46609bb37f011e5cc2ac52d878b1d7214fd2b07f0d::qga {
    struct QGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGA>(arg0, 9, b"QGA", b"qq", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/719fc64d-8294-4a95-843f-eb55eb494d13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

