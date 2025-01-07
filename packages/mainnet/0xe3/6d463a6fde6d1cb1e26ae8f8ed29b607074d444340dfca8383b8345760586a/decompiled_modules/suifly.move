module 0xe36d463a6fde6d1cb1e26ae8f8ed29b607074d444340dfca8383b8345760586a::suifly {
    struct SUIFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLY>(arg0, 6, b"Suifly", b"SuiFly", b"A community-driven meme coin on Sui Network, representing freedom, creativity, and limitless possibilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifly_679a9fe404.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

