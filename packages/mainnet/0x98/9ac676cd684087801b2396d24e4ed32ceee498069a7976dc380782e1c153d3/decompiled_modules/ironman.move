module 0x989ac676cd684087801b2396d24e4ed32ceee498069a7976dc380782e1c153d3::ironman {
    struct IRONMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRONMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRONMAN>(arg0, 9, b"IRONMAN", b"Iron man", b"IRON MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/722f04e1-99b7-4a9a-aa0a-9d1c1c4d4241.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRONMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRONMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

