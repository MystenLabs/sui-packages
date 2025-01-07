module 0xe3f811307335f869eebfe9e4a4893a8fcb2c694a1a9071340f88aa79a5591cc8::tula {
    struct TULA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TULA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TULA>(arg0, 9, b"TULA", b"Tulanh", b"Troll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f753ee0-845b-4e61-a250-9dd9bfaa3111.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TULA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TULA>>(v1);
    }

    // decompiled from Move bytecode v6
}

