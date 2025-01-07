module 0x528927c79adef5a88a034fe44d0b148ab32fbc9df825591abbea494ab041781c::tuof {
    struct TUOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUOF>(arg0, 9, b"TUOF", b"FFW;", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01af95d0-3ad1-45c1-9193-eaf869665248.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

