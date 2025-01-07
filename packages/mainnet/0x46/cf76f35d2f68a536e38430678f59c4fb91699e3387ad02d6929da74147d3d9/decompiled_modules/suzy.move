module 0x46cf76f35d2f68a536e38430678f59c4fb91699e3387ad02d6929da74147d3d9::suzy {
    struct SUZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZY>(arg0, 6, b"Suzy", b"Suzy The Frog", b"She is Suzy so cute blue frog from the Sui Ocean. Her heart is the really blue chip. Make together her a blue chip meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1206_33ce74c523.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

