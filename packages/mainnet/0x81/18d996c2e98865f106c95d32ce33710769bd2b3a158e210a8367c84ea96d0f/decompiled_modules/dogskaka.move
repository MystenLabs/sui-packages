module 0x8118d996c2e98865f106c95d32ce33710769bd2b3a158e210a8367c84ea96d0f::dogskaka {
    struct DOGSKAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAKA>(arg0, 9, b"DOGSKAKA", b"Kaka", b"I won mis to", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4968c9ab-b1a5-43d8-81db-67c91e61abe9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

