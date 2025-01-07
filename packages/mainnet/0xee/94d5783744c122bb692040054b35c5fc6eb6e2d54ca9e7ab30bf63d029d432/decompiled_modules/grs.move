module 0xee94d5783744c122bb692040054b35c5fc6eb6e2d54ca9e7ab30bf63d029d432::grs {
    struct GRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRS>(arg0, 9, b"GRS", b"Grass", b"slow and slow it grows and need to be cut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/547c44f3-2cdf-482f-be43-857672863e38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

