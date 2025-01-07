module 0x2e031a172cb34a58c1af98230a4058cb3454fd2a78a532b16c1df1d247b392a7::kitti {
    struct KITTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTI>(arg0, 9, b"KITTI", b"Kitty ", b"Cute kitty ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/667910a0-0f62-4fe8-a117-d6ef5e75b6dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

