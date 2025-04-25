module 0x59ca410a3cdf8f5341b5e67b56be0c84db2098f8761ebdb5a19862d2471eb078::luxury {
    struct LUXURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUXURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUXURY>(arg0, 6, b"LUXURY", b"Sui Luxury", b"Luxury - No one knows whether he is a wise trading guru or just a chaotic creature who likes to watch charts burn. One thing is certain: where there's candles, there's movement... and Candles never stand still.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062118_2a102491da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUXURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUXURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

