module 0x8c66199336d3b631768a8da6ffd6ed03ee5eb5b466f6ae5e5cddbb0b6b24dc62::t627627865 {
    struct T627627865 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T627627865, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T627627865>(arg0, 9, b"T627627865", b"pigs", b"This is the cutest pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91f4cbd9-7c38-4fd4-89b7-f008ce707e21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T627627865>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T627627865>>(v1);
    }

    // decompiled from Move bytecode v6
}

