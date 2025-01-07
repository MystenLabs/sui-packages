module 0x724cfa4d7b68700970d8ab2893a72f455b9b238d4b1e7b1bba6b645b99157e98::fdh {
    struct FDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDH>(arg0, 9, b"FDH", b"JGK", b"FGN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04cf51d8-08ae-41ba-a320-6466a591971f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

