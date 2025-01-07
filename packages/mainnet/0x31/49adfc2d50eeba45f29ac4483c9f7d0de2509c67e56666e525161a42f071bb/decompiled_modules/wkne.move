module 0x3149adfc2d50eeba45f29ac4483c9f7d0de2509c67e56666e525161a42f071bb::wkne {
    struct WKNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKNE>(arg0, 9, b"WKNE", b"gvs", b"hdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04321e18-80ae-42ff-ae2a-05162c68ce08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

