module 0x6ed72ae69e570b7d0e19e7897169b2ad8c537a1b4e0618aef02e9d579ae4e41c::ddf {
    struct DDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDF>(arg0, 9, b"DDF", b"DoDaFu", b"Nice token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61303cb6-90b9-4be2-88af-e5b11bcf08bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

