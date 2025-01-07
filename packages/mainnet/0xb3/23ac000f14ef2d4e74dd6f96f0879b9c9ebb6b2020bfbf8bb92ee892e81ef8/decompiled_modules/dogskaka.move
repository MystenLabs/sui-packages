module 0xb323ac000f14ef2d4e74dd6f96f0879b9c9ebb6b2020bfbf8bb92ee892e81ef8::dogskaka {
    struct DOGSKAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAKA>(arg0, 9, b"DOGSKAKA", b"Wawe", b"I won mis to kanfnc mfnajxj sksnxn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1564a2b1-91ef-4503-9d8c-ea069ad13cac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

