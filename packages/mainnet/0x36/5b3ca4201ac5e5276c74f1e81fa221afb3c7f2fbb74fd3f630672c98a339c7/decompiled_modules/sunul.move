module 0x365b3ca4201ac5e5276c74f1e81fa221afb3c7f2fbb74fd3f630672c98a339c7::sunul {
    struct SUNUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNUL>(arg0, 9, b"SUNUL", b"The sunul", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/507e67d6-f425-43b6-99a8-b1bc4871e9e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

