module 0x6a6db6dd587a834745bfaafead4e61a40d3dc8fbb056ad00930a5196bb6b16ca::toyu {
    struct TOYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOYU>(arg0, 9, b"TOYU", b"Ty", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6a9d70d-40e3-4129-a9ec-7d3c22a960fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

