module 0xe4464563496c9c71e3d331a2a00eb2d9455144f579611765022c4339a4d63f7e::qwe {
    struct QWE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QWE>, arg1: 0x2::coin::Coin<QWE>) {
        0x2::coin::burn<QWE>(arg0, arg1);
    }

    fun init(arg0: QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWE>(arg0, 6, b"QWE", b"qwe", b"rgrved", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<QWE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QWE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

