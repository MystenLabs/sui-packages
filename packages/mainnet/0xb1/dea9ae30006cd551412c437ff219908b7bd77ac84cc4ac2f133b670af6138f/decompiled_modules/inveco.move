module 0xb1dea9ae30006cd551412c437ff219908b7bd77ac84cc4ac2f133b670af6138f::inveco {
    struct INVECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVECO>(arg0, 9, b"INVECO", b"INVESTCOIN", b"Investment coins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00dd230c-1c4a-43be-b512-91c935c67aef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

