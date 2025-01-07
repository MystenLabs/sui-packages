module 0xf3c748a76d93cd07212ee938ae55f159e01fb90f1feb9fdc8625f25691e51d4e::sia {
    struct SIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIA>(arg0, 9, b"SIA", b"Siavash ", b"Best cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60e18aa1-274d-45e5-ada4-752b74e09c48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

