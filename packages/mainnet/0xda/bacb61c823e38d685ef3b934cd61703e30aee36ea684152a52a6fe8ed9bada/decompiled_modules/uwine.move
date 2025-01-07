module 0xdabacb61c823e38d685ef3b934cd61703e30aee36ea684152a52a6fe8ed9bada::uwine {
    struct UWINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UWINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UWINE>(arg0, 9, b"UWINE", b"shksn", b"ndnb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/353d7691-af09-4819-96cd-75add1ba78af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UWINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UWINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

