module 0xfbeb5172f5d8d1390490137ea519d91f22f892f8f53a61ff80858b8429d3d7f3::xhsjs {
    struct XHSJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHSJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XHSJS>(arg0, 9, b"XHSJS", b"hejdn", b"jdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87ccb140-07a6-4213-888f-455aa9cffe2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHSJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XHSJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

