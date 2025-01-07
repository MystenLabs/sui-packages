module 0x6aabee079d14fd3672dee0bd720a48a9c8afa54647cfd6a7d1b0e5e7e89ebcca::no {
    struct NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO>(arg0, 9, b"NO", b"Ngocbichno", b"Bichmap 111222000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6d4b52f-afc2-462d-a5e6-cd23ca1357a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO>>(v1);
    }

    // decompiled from Move bytecode v6
}

