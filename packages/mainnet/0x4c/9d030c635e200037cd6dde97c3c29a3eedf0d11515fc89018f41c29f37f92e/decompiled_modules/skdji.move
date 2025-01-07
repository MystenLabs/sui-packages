module 0x4c9d030c635e200037cd6dde97c3c29a3eedf0d11515fc89018f41c29f37f92e::skdji {
    struct SKDJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKDJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKDJI>(arg0, 9, b"SKDJI", b"saz", b"hsns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5555a89-0521-4277-b619-4a68d0b85a63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKDJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKDJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

