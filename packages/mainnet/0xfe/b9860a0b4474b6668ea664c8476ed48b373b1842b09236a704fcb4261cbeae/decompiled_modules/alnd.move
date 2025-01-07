module 0xfeb9860a0b4474b6668ea664c8476ed48b373b1842b09236a704fcb4261cbeae::alnd {
    struct ALND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALND>(arg0, 9, b"ALND", b"AlienDolla", x"20412063757272656e63792074686174e2809973207472756c79206f7574206f66207468697320776f726c642c20416c69656e446f6c6c617220697320746865206f6e6c792077617920746f2070617920696e20737061636521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e22f52d8-e76f-43f0-bbf7-315ab6376961.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALND>>(v1);
    }

    // decompiled from Move bytecode v6
}

