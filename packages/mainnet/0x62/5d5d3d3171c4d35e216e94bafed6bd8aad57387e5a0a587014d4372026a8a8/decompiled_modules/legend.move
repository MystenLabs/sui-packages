module 0x625d5d3d3171c4d35e216e94bafed6bd8aad57387e5a0a587014d4372026a8a8::legend {
    struct LEGEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGEND>(arg0, 9, b"LEGEND", b"MEGALODON", x"4d656d652070756d7020636f696e20f09f94a5f09f94a5f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ab9e94c-af34-4fe0-a63a-157b2e66c2f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

