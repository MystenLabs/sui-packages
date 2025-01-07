module 0x4a14dfae4f28b36b0203c62a7e4cf1ae94e654f88952f179782abbbd1b75e9eb::kb {
    struct KB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KB>(arg0, 9, b"KB", b"Kha", b"Kha Banh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c737cd9f-a4b3-404a-8924-17bc359e2950.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KB>>(v1);
    }

    // decompiled from Move bytecode v6
}

