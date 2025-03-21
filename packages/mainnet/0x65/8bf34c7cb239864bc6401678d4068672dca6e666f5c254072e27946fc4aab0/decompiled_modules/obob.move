module 0x658bf34c7cb239864bc6401678d4068672dca6e666f5c254072e27946fc4aab0::obob {
    struct OBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBOB>(arg0, 9, b"OBOB", b"BOBO", b"Its Create For A Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/504aff96-2d40-4811-96f4-f55135647198.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

