module 0x5ddba9f00b1a632ab949761bcf139a612417fa157fdcdca1f15804ef8a5504c::tsdsdsds {
    struct TSDSDSDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSDSDSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSDSDSDS>(arg0, 9, b"TSDSDSDS", b"thghghddmm", b"iuiuiugfgfzxzx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fd16822-66bf-4b4c-aac8-4e4e3805266e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSDSDSDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSDSDSDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

