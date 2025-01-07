module 0x7270a53b935f6586bbbd124e9b4228fe9138263818ea1f90fd84d66b72b979b5::bk {
    struct BK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BK>(arg0, 9, b"BK", b"Baby Kong", b"Baby kong ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f70bf1c-7bf3-4edd-8301-7a5203f2d0da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BK>>(v1);
    }

    // decompiled from Move bytecode v6
}

