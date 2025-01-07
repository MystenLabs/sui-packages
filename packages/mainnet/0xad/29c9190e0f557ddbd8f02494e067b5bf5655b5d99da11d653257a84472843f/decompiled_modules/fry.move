module 0xad29c9190e0f557ddbd8f02494e067b5bf5655b5d99da11d653257a84472843f::fry {
    struct FRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRY>(arg0, 6, b"FRY", b"Sui Fry", b"Crispy meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_090916_f77a44ea5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

