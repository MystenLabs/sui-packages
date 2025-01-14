module 0xaeabe64c0c7e6768d775c997a4a228e4e9c3d5394d547ae3e881e46957ce9d2b::dgpu {
    struct DGPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGPU>(arg0, 6, b"DGPU", b"Dante GPU", x"44414e54452d47505520697320616e204149206167656e74206d61726b6574706c61636520616e64206167656e74207468617420696e74656c6c6967656e746c79207265636f6d6d656e64732074686520636f6d62696e6174696f6e206f66204149206d6f64656c20616e64204750552074686174206265737420737569747320757365727327206e656564732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736896676388.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

