module 0xc7bb323c0134ee2bee36c62fb52178da3e7d36455a1dfdf9af4750598a10d19f::wtg {
    struct WTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTG>(arg0, 9, b"WTG", b"Warthog ", b"Created it for warthog lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03c44f92-795e-4642-b331-71c5be916296.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

