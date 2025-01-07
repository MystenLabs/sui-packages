module 0xfb3e28f79f723e534554e4eac59b6783d53348deede5adbf68c4ac4c20a45125::wedoge {
    struct WEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGE>(arg0, 9, b"WEDOGE", b"WeweDoge", b"Wewe Doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ce2dbcc-a956-4869-bac8-13395a952140.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

