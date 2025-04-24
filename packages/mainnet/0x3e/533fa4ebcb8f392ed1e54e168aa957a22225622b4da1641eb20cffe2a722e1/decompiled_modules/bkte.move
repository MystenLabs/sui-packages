module 0x3e533fa4ebcb8f392ed1e54e168aa957a22225622b4da1641eb20cffe2a722e1::bkte {
    struct BKTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKTE>(arg0, 6, b"Bkte", b"Biawak the cute", b"Halo all the is my coin meme firstime. I hope you like our presence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012888_ffab195928.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

