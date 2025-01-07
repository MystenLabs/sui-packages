module 0xfacb857179a6ec7759677d76563f12f5ff88b3292723681552129d1b95fc4918::cch {
    struct CCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCH>(arg0, 9, b"CCH", b"cherry", b"like a lady", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cc8f868-08f6-43fe-bba9-935b4065654a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

