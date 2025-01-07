module 0x6f85c798354ba2e89f96f682545a97149c83fd0af34e9af82eda90dbfd8cf969::lqr {
    struct LQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LQR>(arg0, 6, b"LQR", b"Liquor", b"Be liquor, my friend. New era of meme on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/liquer_acf39b57e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

