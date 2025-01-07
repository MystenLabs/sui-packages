module 0xf06f8c8d567c05756c7822fdfc4ed3e8842596dd88f23d09a8a42e236b278b30::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 9, b"BUB", b"Bubble", x"466c792068696768207769746820427562626c65436f696e3a20546865206368697270696573742063727970746f63757272656e6379207468617427732074616b696e6720746865206d656d6520776f726c642062792073746f726d2c206f6e6520747765657420617420612074696d652120f09f92b80a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bb1a9fe-f3f5-4d47-9a62-23e4aaa69b97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

