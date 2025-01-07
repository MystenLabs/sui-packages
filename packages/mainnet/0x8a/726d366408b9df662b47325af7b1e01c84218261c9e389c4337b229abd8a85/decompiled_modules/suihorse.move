module 0x8a726d366408b9df662b47325af7b1e01c84218261c9e389c4337b229abd8a85::suihorse {
    struct SUIHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHORSE>(arg0, 6, b"SUIHORSE", b"Sui Horse", b"on the depth of the ocean, where every creatures live beneath the sea, you will find the one the you've been missing... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731947546253.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIHORSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHORSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

