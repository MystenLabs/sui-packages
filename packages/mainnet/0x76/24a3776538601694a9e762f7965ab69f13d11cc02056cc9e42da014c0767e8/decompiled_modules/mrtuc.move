module 0x7624a3776538601694a9e762f7965ab69f13d11cc02056cc9e42da014c0767e8::mrtuc {
    struct MRTUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRTUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRTUC>(arg0, 6, b"MRTUC", b"MRTuc Sui", b"Mrtuc new meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000637_ac530d82b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRTUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRTUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

