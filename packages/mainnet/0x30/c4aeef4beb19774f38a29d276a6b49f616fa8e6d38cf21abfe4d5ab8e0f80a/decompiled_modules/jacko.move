module 0x30c4aeef4beb19774f38a29d276a6b49f616fa8e6d38cf21abfe4d5ab8e0f80a::jacko {
    struct JACKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKO>(arg0, 6, b"JACKO", b"Moon Jacko", b"Join the Moon Jacko pack and howl at the moon of endless meme possibilities! Have fun and make #JACKO the most widely held #memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/android_chrome_512x512_401f7309d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

