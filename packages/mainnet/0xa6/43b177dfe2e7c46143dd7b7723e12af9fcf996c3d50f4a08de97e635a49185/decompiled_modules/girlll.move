module 0xa643b177dfe2e7c46143dd7b7723e12af9fcf996c3d50f4a08de97e635a49185::girlll {
    struct GIRLLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRLLL>(arg0, 9, b"GIRLLL", b"Fine girl", x"46696e65206769726c207769746820737465657a65f09f9881f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/edebed85-6ad4-4c16-bbf5-964dafa439c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRLLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRLLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

