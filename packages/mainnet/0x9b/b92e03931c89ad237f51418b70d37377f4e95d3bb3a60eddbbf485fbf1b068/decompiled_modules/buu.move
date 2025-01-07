module 0x9bb92e03931c89ad237f51418b70d37377f4e95d3bb3a60eddbbf485fbf1b068::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUU>(arg0, 9, b"BUU", b"Buu", b"Buu Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dc7a538-70fe-472c-acc4-36189e3dff54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

