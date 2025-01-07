module 0xa70c360ab9fe62c4c6f6480fa75f120c33d57fa0b03b26e88d3b0b54ee491199::degtyhu {
    struct DEGTYHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTYHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTYHU>(arg0, 9, b"DEGTYHU", b"ghghkjtgh", b"bnhdgjy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/708ceefb-4899-46d9-bc27-f507fe89e5c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTYHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTYHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

