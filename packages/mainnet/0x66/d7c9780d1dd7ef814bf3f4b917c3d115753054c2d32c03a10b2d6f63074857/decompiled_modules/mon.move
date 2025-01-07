module 0x66d7c9780d1dd7ef814bf3f4b917c3d115753054c2d32c03a10b2d6f63074857::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"MON", b"MONYET", b"Stupid People Like a Monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b60b7c19-21c6-4e0d-ae37-4ccf1525b488.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
    }

    // decompiled from Move bytecode v6
}

