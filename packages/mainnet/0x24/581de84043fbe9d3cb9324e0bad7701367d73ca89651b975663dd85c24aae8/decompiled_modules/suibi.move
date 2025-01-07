module 0x24581de84043fbe9d3cb9324e0bad7701367d73ca89651b975663dd85c24aae8::suibi {
    struct SUIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBI>(arg0, 6, b"SUIBI", b"Suibi Sui", b"Sui chain Meme Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029256_c19e0fb57a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

