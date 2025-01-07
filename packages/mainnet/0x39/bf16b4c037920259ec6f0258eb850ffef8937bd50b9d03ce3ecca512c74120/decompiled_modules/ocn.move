module 0x39bf16b4c037920259ec6f0258eb850ffef8937bd50b9d03ce3ecca512c74120::ocn {
    struct OCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCN>(arg0, 9, b"OCN", b"OCEAN", b"there is no such thing as too much water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bd1d510-c01f-40dc-bfd0-879b650b33df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

