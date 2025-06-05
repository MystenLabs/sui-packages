module 0x60270f7041d68abfebb1905e372584a3d191e898aec77ae1e06bb2b7a5428cb4::emai {
    struct EMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMAI>(arg0, 6, b"EMAI", b"elon mask Ai", b"Best EMAi on the moon space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2319_0cdf300fec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

