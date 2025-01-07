module 0xf764c2de682070eedcd2b3023fc833b89e490df1155515750d90801ce350d8ed::bysi {
    struct BYSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYSI>(arg0, 9, b"BYSI", b"Baby sui", b"Nothing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b42b04f-9443-4cab-abc7-c3ea7a99b5d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

