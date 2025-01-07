module 0x566372d32ef91cb62544516f35926eb5c3da2dcd1d0669777fd8d648862c440f::danny {
    struct DANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANNY>(arg0, 9, b"DANNY", b"Danny rac", b"Danny the racoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6902547-9199-436e-851a-ab1aac0e09bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

