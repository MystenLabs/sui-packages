module 0x30e5895ffc84da9c5b1c7d62d3eb353a65c5402fc04b59fda42470283f73450f::gr {
    struct GR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GR>(arg0, 9, b"GR", b"RG", b"DSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/253c3573-fa9f-432c-8e00-3321d18f0134.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GR>>(v1);
    }

    // decompiled from Move bytecode v6
}

