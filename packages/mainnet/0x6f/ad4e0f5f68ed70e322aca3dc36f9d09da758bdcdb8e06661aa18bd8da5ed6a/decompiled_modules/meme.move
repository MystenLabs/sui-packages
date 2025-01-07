module 0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 18, b"MEME", b"MEME", b"sahab's meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/162699534")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MEME>>(v0);
    }

    // decompiled from Move bytecode v6
}

