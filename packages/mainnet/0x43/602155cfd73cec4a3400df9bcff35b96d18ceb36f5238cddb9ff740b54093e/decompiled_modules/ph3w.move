module 0x43602155cfd73cec4a3400df9bcff35b96d18ceb36f5238cddb9ff740b54093e::ph3w {
    struct PH3W has drop {
        dummy_field: bool,
    }

    fun init(arg0: PH3W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PH3W>(arg0, 6, b"PH3W", b"ph3w", b"ph3w for every gunsh0t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dwasdsui_f6e57557a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PH3W>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PH3W>>(v1);
    }

    // decompiled from Move bytecode v6
}

