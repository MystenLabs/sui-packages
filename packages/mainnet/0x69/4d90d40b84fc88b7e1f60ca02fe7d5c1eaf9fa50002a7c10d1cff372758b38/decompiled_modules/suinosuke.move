module 0x694d90d40b84fc88b7e1f60ca02fe7d5c1eaf9fa50002a7c10d1cff372758b38::suinosuke {
    struct SUINOSUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOSUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOSUKE>(arg0, 6, b"SUINOSUKE", b"Suinosuke", x"5361792068657921202d20486579210a5368696e204368616e210a4c6f6f6b696e6720666f722074726f75626c652c206865277320796f7572206d616e0a200a5361792068657921202d20486579210a5368696e204368616e210a4865277320627265616b696e67207468652072756c65732074686520626573742068652063616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5316541362346_e4ced5c099.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOSUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOSUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

