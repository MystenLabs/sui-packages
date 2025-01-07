module 0xd5e3daf5871330dddc0d097a1dbd5cfe345bf765e440703671350daaf22de7e9::hfd {
    struct HFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFD>(arg0, 9, b"HFD", b"F", b"FDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6cbf2a6-ffc8-4b1e-9414-8039a5c95242.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

