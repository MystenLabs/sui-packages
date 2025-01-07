module 0xf48a431091989b4ff622feb78a2e0ec1b63055f890d76ec4ea26156f75cce9ca::fbpride {
    struct FBPRIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBPRIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBPRIDE>(arg0, 9, b"FBPRIDE", b"Fb", b"Fbrpide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a119c083-7e15-429a-909b-89d7000dc3d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBPRIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FBPRIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

