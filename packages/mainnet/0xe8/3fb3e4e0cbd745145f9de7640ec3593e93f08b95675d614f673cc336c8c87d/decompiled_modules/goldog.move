module 0xe83fb3e4e0cbd745145f9de7640ec3593e93f08b95675d614f673cc336c8c87d::goldog {
    struct GOLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDOG>(arg0, 9, b"GOLDOG", b"Golden dog", x"474f4c44454e20444f472069732061206d656d6520636f696e207468617420686173206e6f20737065636966696320707572706f73652c206a757374206372656174656420666f722066756e2c2068617320636f6d6d6f646974696573206f7267616e697a656420627920636f6d6d6f6469746965732e2e2e20616e6420676976657320617070726563696174696f6e20746f2069747320636f6d6d6f64697469657320736f6d6564617920f09f988d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0e75dbc-daf3-4bf8-95aa-80eb54d6ab89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

