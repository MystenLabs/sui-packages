module 0x8cf144016d3972ccff507450572ec6e546b6706c75045ae18cb0b7069e818b31::snipe {
    struct SNIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPE>(arg0, 6, b"SNIPE", b"SONIC SNIPE", b"$Sniper is The best meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240929_145042_ec3337c665.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

