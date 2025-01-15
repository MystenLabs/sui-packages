module 0x7fff542f7475e1dd145f81ce1f98cf0f946132f7aad6e12f5da47e413d8e5e73::lunas {
    struct LUNAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUNAS>(arg0, 6, b"LUNAS", b"LUNA AI on SUI by SuiAI", b"$LUNAS: Combining the power of AI and memes, on the Sui.platform, an investment opportunity not to be missed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Them_tieu_de_1204_x_1204_px_1204_x_1204_px_1204_x_850_px_1215_x_1215_px_1230_x_1215_px_1230_x_1000_px_1230_x_1000_px_1250_x_1000_px_1300_x_1000_px_1350_x_1000_px_7_f71b9247db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUNAS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNAS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

