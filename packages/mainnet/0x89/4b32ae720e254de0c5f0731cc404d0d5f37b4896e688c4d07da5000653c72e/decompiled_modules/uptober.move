module 0x894b32ae720e254de0c5f0731cc404d0d5f37b4896e688c4d07da5000653c72e::uptober {
    struct UPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOBER>(arg0, 6, b"Uptober", b"Suitober", x"49742773207570746f626572206f6e207375690a0a0a53706f6e736f72656420427920537569204675656c20244655454c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6037_2043f506e4.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

