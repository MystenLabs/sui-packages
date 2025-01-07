module 0x127d2603fba03fec0630cb79a993433c1c9a632f7296e125747080656528977f::gfd {
    struct GFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFD>(arg0, 9, b"GFD", b"GDSA", b"B VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5880104-4378-4006-bfef-a37b2c28d62d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

