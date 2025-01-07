module 0x9e66813e8d3f2906eb0b82dbd144546678787f26b5e08add0da31b1c3d60d3e8::btt {
    struct BTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTT>(arg0, 6, b"BTT", b"Blocky Treasure", b"Join us in this exciting journey as we redefine the boundaries of digital currency with Pixel Realm Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735888663049.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

