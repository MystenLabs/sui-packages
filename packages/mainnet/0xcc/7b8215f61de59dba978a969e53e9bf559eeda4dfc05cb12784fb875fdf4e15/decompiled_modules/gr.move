module 0xcc7b8215f61de59dba978a969e53e9bf559eeda4dfc05cb12784fb875fdf4e15::gr {
    struct GR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GR>(arg0, 9, b"GR", b"RG", b"DSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31ef1e77-d51c-4a16-8486-95893cb53bd0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GR>>(v1);
    }

    // decompiled from Move bytecode v6
}

