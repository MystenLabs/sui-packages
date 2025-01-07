module 0xd331f1f7abbe667039ee9bd4389b091da823812cfa52706b898f49aad953f7df::wbull {
    struct WBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBULL>(arg0, 9, b"WBULL", b"Bull", b"Bull on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b0e21d5-052f-499f-946c-335d2948d200.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

