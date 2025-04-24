module 0xa1f36c318a1591da244a22289524dd23ca905be3a22c9d190646fdb893179b51::bkte {
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

