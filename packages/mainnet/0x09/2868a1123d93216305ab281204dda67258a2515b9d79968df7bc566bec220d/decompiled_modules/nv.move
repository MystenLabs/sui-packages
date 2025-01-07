module 0x92868a1123d93216305ab281204dda67258a2515b9d79968df7bc566bec220d::nv {
    struct NV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NV>(arg0, 9, b"NV", b"Nc", b"Forfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f404f35-dbe7-4b28-a9e7-fb1d528a6139.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NV>>(v1);
    }

    // decompiled from Move bytecode v6
}

