module 0x48479821cdb3dbc8c63ff7bc709db6e9d3ff18ed410d87fa4e6d2c6e8125f0ff::ptk {
    struct PTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTK>(arg0, 9, b"PTK", b"Puttotalk", b"Silen or talk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d81bbd37-2a14-45bc-a56c-103263cc2228.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

