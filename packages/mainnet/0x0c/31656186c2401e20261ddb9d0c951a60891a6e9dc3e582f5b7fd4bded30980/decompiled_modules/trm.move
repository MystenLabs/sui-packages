module 0xc31656186c2401e20261ddb9d0c951a60891a6e9dc3e582f5b7fd4bded30980::trm {
    struct TRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRM>(arg0, 9, b"TRM", b"Trumpy", b"This token is made by the community for fan. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/731dd11b-a820-4b13-b5a1-62913934ce5e-1000018942.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

