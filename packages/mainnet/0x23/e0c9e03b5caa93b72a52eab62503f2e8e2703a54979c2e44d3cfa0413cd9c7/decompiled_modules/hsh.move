module 0x23e0c9e03b5caa93b72a52eab62503f2e8e2703a54979c2e44d3cfa0413cd9c7::hsh {
    struct HSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSH>(arg0, 9, b"HSH", b"HASHASHIN", b"HASHASHIN ARE THE FIRST ASSASSINS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9ab1704-f750-480a-9a5d-6aa4446f78c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

