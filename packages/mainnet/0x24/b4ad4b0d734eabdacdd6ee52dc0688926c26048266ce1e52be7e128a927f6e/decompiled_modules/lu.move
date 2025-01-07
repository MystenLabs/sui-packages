module 0x24b4ad4b0d734eabdacdd6ee52dc0688926c26048266ce1e52be7e128a927f6e::lu {
    struct LU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LU>(arg0, 9, b"LU", b"lu", b"lululu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1cadd9ac-b027-4878-a56a-5ee9c39fb706.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LU>>(v1);
    }

    // decompiled from Move bytecode v6
}

