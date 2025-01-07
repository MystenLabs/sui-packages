module 0x8976cb6d8bd330e4b0735b4965b3bb3bd6f59d089b558c70aeacaed77c83c0b2::tif {
    struct TIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIF>(arg0, 6, b"TIF", b"THIS IS FINE", b"THIS IS FINE IT IS ALL FINE WAGMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6065_3e700a15c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

