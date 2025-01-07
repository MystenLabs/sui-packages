module 0x8a3b0e72b66db1be142a3bbe5f59978aa82fba321b21ff50d0aec5d8e769b7ed::crottoken {
    struct CROTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROTTOKEN>(arg0, 9, b"CROTTOKEN", b"Crot", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f34ea019-055b-4cee-90c0-84fba4f41c84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROTTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

