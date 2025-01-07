module 0x88951d7f2ba61b103b7e8cf7070a5af341106e2ea5bca65ece70a1e9d715f1d7::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"WoofCoin", b" Bark up some profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a514076-1d52-4c2f-964d-17e4357fc6d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

