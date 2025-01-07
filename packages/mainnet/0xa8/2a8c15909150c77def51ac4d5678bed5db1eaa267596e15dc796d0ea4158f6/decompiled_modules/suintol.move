module 0xa82a8c15909150c77def51ac4d5678bed5db1eaa267596e15dc796d0ea4158f6::suintol {
    struct SUINTOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINTOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINTOL>(arg0, 6, b"SUINTOL", b"Suintol Koore i69", x"3639204d206b656b652c206170204936392d3432303058585820437065657520746f6f20362c363647687a0a57656c63756d20746f205375696e746f6c20636f6f72652046616d756c79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaas_55aaa46ead.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINTOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINTOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

