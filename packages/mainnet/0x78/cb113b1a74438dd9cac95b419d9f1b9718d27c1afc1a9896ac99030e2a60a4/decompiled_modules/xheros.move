module 0x78cb113b1a74438dd9cac95b419d9f1b9718d27c1afc1a9896ac99030e2a60a4::xheros {
    struct XHEROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHEROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XHEROS>(arg0, 9, b"XHEROS", b"heroS", b"wonderful ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc4b6767-7131-49e9-9f39-1e57189414da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHEROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XHEROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

