module 0x4ac28b246eda43142c604b99924b04e350b3f176b0ac558e0fd8ff702650f512::poir {
    struct POIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POIR>(arg0, 9, b"POIR", b"POIROT", b"Hercule Poirot Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fea168a-3914-4da3-b97f-a21be3a87c4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

