module 0xa518e0d51f4de070b5322ef9854d3e4ca438dd1e4a656b7ab6904b9520409206::frd {
    struct FRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRD>(arg0, 9, b"FRD", b"frida", b"The inspired cryptocurrency that's painting profits with vibrant strokes./.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44bfdfd3-9037-4a6c-9377-f39e47eb4861.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

