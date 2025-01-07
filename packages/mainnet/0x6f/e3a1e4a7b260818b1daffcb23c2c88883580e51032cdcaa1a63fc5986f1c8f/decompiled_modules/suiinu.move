module 0x6fe3a1e4a7b260818b1daffcb23c2c88883580e51032cdcaa1a63fc5986f1c8f::suiinu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 6, b"SUIINU", b"Sui inu", b"Shi chain Meme Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029182_62da5fee7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

