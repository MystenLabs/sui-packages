module 0x41c116fdf359deb0d54016d4fdcadf669e4926306077d746793e98808ea8a671::gfm {
    struct GFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFM>(arg0, 6, b"GFM", b"Good F*cking Morning", b"This bull run is gonna be massive. We'll be saying 'GFM' all the way through it. Use #GFM on X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737831672661.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

