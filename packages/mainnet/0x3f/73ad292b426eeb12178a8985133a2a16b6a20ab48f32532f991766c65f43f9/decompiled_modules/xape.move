module 0x3f73ad292b426eeb12178a8985133a2a16b6a20ab48f32532f991766c65f43f9::xape {
    struct XAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAPE>(arg0, 9, b"XAPE", b"X APE", b"XX APE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6e6ec77-a636-404b-953f-48604e16ce7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

