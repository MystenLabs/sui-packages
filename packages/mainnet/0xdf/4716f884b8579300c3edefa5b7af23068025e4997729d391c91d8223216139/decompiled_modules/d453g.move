module 0xdf4716f884b8579300c3edefa5b7af23068025e4997729d391c91d8223216139::d453g {
    struct D453G has drop {
        dummy_field: bool,
    }

    fun init(arg0: D453G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D453G>(arg0, 9, b"D453G", b"Wave DUCK ", b"A memecoin for pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15e35e14-2445-4fe7-a740-aefa8a7254df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D453G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D453G>>(v1);
    }

    // decompiled from Move bytecode v6
}

