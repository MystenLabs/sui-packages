module 0xf45bd675422022d39782621f39cb67520f9baa68aca280ccb31739595c136a9::pixelbridge {
    struct PIXELBRIDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXELBRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXELBRIDGE>(arg0, 6, b"PIXELBRIDGE", b"Pixel Bridge", b"Transfer stablecoins between EVM& non-EVM chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3242_3b14804ca6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXELBRIDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXELBRIDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

