module 0x4d2c5d68bd79a1bb691eb39894d9557e8fc0381a86a376f7065ce62d85c3b35c::bk {
    struct BK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BK>(arg0, 9, b"BK", b"Baby Kong", b"Baby kong ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0da500fa-df44-4c8a-b099-107e4cd2cd7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BK>>(v1);
    }

    // decompiled from Move bytecode v6
}

