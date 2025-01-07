module 0x6cfa05d405f3d897e6b430763fe0f98196969b0abfb9640426725403bd30d245::drox {
    struct DROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROX>(arg0, 6, b"DROX", b"Sui Drox", b"$DROX loves chilling with his bros PEPE and PONKE, but at some point they're doomed to become his next meal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c30c96126a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

