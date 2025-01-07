module 0xd8c60b996b5cb0440348848d4902f02d709c67b26e015e534dc8820e39260b87::trck {
    struct TRCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRCK>(arg0, 9, b"TRCK", b"Truck", b"Truck drivers token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87fe2c1f-9360-4913-9a5a-106a74fa84cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

