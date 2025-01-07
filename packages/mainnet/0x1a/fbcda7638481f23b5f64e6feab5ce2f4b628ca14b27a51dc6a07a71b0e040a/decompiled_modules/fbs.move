module 0x1afbcda7638481f23b5f64e6feab5ce2f4b628ca14b27a51dc6a07a71b0e040a::fbs {
    struct FBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBS>(arg0, 6, b"FBS", b"Famgonba Sui", b"Dragonballz family meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34f7215cc8017b8bf436a9b575d777c3_removebg_preview_d13963fd76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

