module 0x8bf8b29a02ff94433f0c4600c1e485aa89348bdc2e1b7bfe3d0c5965d759df7d::erenyeager {
    struct ERENYEAGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERENYEAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERENYEAGER>(arg0, 9, b"ERENYEAGER", b"Eren", b"Attackontitan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4974c384-769c-4af9-abe5-859c53e3bd1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERENYEAGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERENYEAGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

