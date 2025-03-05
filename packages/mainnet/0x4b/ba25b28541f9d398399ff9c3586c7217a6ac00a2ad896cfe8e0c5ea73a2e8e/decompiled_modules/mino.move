module 0x4bba25b28541f9d398399ff9c3586c7217a6ac00a2ad896cfe8e0c5ea73a2e8e::mino {
    struct MINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINO>(arg0, 6, b"MINO", b"Mino", b"Mino is an innovative memecoin launched on the SUI blockchain, designed to provide a fun and entertaining experience for users and investors. Inspired by the rapidly growing meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063283_95312d5f3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

