module 0x8b84969617b42b7e9f2b48e4da61e7ef00566ede21d0fd84dd5d0c7fb5a81f8c::asif {
    struct ASIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASIF>(arg0, 9, b"ASIF", b"Muhammad ", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01756d12-be93-4ee7-93cf-a9d83bbb686e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

