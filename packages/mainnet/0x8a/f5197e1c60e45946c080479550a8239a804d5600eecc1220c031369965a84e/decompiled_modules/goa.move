module 0x8af5197e1c60e45946c080479550a8239a804d5600eecc1220c031369965a84e::goa {
    struct GOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOA>(arg0, 9, b"GOA", b"goats", b"the goats coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/942694cc-e823-467d-9f46-28992968cb78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

