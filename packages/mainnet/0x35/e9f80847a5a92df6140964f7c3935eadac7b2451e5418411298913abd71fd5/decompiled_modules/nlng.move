module 0x35e9f80847a5a92df6140964f7c3935eadac7b2451e5418411298913abd71fd5::nlng {
    struct NLNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLNG>(arg0, 9, b"NLNG", b"Nailong Me", b"CUTEST NAILOONG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/faf62389-d838-475a-aac8-964f7fb364e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

