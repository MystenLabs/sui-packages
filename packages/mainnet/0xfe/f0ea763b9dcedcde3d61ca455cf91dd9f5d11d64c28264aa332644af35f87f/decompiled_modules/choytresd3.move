module 0xfef0ea763b9dcedcde3d61ca455cf91dd9f5d11d64c28264aa332644af35f87f::choytresd3 {
    struct CHOYTRESD3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOYTRESD3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOYTRESD3>(arg0, 9, b"CHOYTRESD3", b"MeM$", b"Coin fruts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03f4e60c-2617-4c9f-b0b0-af6779287ad7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOYTRESD3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOYTRESD3>>(v1);
    }

    // decompiled from Move bytecode v6
}

