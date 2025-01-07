module 0xda9fcac87fc8a2cc11c96c5613b8a9eab73dc97d411c3110e513c59252d7c7c5::fht {
    struct FHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHT>(arg0, 9, b"FHT", b"Fight", b"fight share victory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed726395-e3f9-456e-becf-d01455a2b039-IMG_6740.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

