module 0xabd256808e80b7f73a66b98658f6e7d338942a2e8e88c8f55ef3dbb5384b5557::grd {
    struct GRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRD>(arg0, 9, b"GRD", b"Garuda", b"Garuda Coin is not just a cryptocurrency; it is a movement toward financial empowerment and digital transformation, aiming to bridge the gap between traditional finance and the emerging digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a9c5a0a-580b-4401-8a15-b156c687812a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

