module 0x1ebca29c0f3355edee567eb0199b9f0d131e3b4d5a9ac53010be1b4d3db7ac04::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"Macedonia", b"Alexander the Great, created one of the largest empires of the ancient world in little over a decade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cb10fdf-e896-4ec4-88d3-b251b1886565.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
    }

    // decompiled from Move bytecode v6
}

