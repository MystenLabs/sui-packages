module 0xab5da2f69b7b0b9997448dd5c2542430b42f351f8c45b2b6974b2977a59a3f8b::bkte {
    struct BKTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKTE>(arg0, 6, b"Bkte", b"Biawak the cute", b"Halo all the is my coin meme firstime. I hope you like our presence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012888_d8515bec30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

