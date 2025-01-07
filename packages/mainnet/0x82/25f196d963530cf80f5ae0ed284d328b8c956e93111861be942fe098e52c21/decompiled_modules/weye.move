module 0x8225f196d963530cf80f5ae0ed284d328b8c956e93111861be942fe098e52c21::weye {
    struct WEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEYE>(arg0, 9, b"WEYE", b"WIERD", b"WEYES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/044833a6-2186-4e41-a75f-a026a210d7c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

