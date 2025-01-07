module 0x2a5db504d6c4a513208e3b3754460fd99b674663cda688d3e0a3ebfd186e9e6c::saigojo {
    struct SAIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIGOJO>(arg0, 9, b"SAIGOJO", b"Gojo", b"Just try it....plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11300b43-f52f-4afc-a85d-19d5ccd65022.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

