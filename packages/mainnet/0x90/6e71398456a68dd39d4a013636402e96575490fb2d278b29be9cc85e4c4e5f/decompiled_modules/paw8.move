module 0x906e71398456a68dd39d4a013636402e96575490fb2d278b29be9cc85e4c4e5f::paw8 {
    struct PAW8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW8>(arg0, 9, b"PAW8", b"Paws", x"4cc3a0206368c3ba2063c3ba6e2063e1bba7612074656c656772616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da1de9cb-fad6-4522-856c-979c6e819e0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAW8>>(v1);
    }

    // decompiled from Move bytecode v6
}

