module 0xd9a3852378be504e4befa117d11b3c28afdc4040b9b33bc75da8a439ab5b5c0a::dolpy {
    struct DOLPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPY>(arg0, 6, b"DOLPY", b"Dolpy", b"Dolpy is more than just a meme coin its a symbol of ambition and determination in the rapidly growing cryptocurrency space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v2fenl_b64eebef40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

