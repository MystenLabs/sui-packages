module 0xa536131b7282387004c5947350d2deddaab2d75983464c7f3e7e374cc085d84c::ded_23 {
    struct DED_23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DED_23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DED_23>(arg0, 9, b"DED_23", b"DED", b"For fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/826a194c-b9cb-4841-9a70-2b1dc9dbc187.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DED_23>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DED_23>>(v1);
    }

    // decompiled from Move bytecode v6
}

