module 0xff315b0dd533cbdb0606979408c5eb5e1d651922ef7c832c23e2fe4bf46ed30a::a4ead {
    struct A4EAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: A4EAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A4EAD>(arg0, 9, b"A4EAD", b"AHEAD", b"AHEAD case", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52344342-6fe7-465e-ba0b-b1d22f4ee04b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A4EAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A4EAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

