module 0x91e0d1abfc9f2734441fa0776e380544a1ad9bd81380c3d76ab31d193f595af6::chunk {
    struct CHUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNK>(arg0, 6, b"CHUNK", b"Chunk", b"$CHUNK is a meme token with no intrinsic value or expectation of financial return. The coin is for entertainment purposes only. Enjoy the meme or get CHUNK'd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014343_6554dedba5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

