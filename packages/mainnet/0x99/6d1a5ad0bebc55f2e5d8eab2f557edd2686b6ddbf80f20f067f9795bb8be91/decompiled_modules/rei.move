module 0x996d1a5ad0bebc55f2e5d8eab2f557edd2686b6ddbf80f20f067f9795bb8be91::rei {
    struct REI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REI>(arg0, 6, b"REI", b"REI 404", b"PVE / Cult Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752495679105.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

