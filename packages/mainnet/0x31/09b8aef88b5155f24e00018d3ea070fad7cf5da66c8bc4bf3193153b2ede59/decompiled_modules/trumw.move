module 0x3109b8aef88b5155f24e00018d3ea070fad7cf5da66c8bc4bf3193153b2ede59::trumw {
    struct TRUMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMW>(arg0, 9, b"TRUMW", b"TrumpWin", b"TrumpWin is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/865e445b-814d-46cc-b9e6-679d2cf60773.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

