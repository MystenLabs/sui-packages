module 0x8598d9f5992d8b16e61be095082abf78c7dfd7334654150163ad08636739623f::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"CATONSUI", b"The first cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e427734-5187-4d96-a359-5ae7931c04fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

