module 0x181c0c34e7535773e1701041640fd253357c6d0c0d33c9ba49881b5925c8bef4::gh {
    struct GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH>(arg0, 9, b"GH", b"FGV", b"GDSFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6565bedb-c913-4ae0-a04f-cb33e76078e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH>>(v1);
    }

    // decompiled from Move bytecode v6
}

