module 0x5c276e4d3b06e2918e131c6d35b06fe18ed5d0bd7040da457ec18e2c101995f0::jt {
    struct JT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JT>(arg0, 9, b"JT", b"JETT", b"Jett Valorant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbda90c9-7496-4c4a-9061-88206c0ce5b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JT>>(v1);
    }

    // decompiled from Move bytecode v6
}

