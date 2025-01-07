module 0xf16d679a9cb3cd710b4b9abd22034557a2579e5ad3b958f449884ef7df99073c::flp {
    struct FLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLP>(arg0, 6, b"FLP", b"FlappyCoin", b"FlappyCoin is a digital token inspired by the lightness of birds, offering fast and secure transactions. It makes the world of cryptocurrencies accessible and fun, inviting you to explore a new way of digital interaction. Join the FlappyCoin communit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733080120729.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

