module 0x4726140e6080f7216880debf6f3a8fcc5b382017499e3f632f2d2ffd2575c01b::purplepudgy {
    struct PURPLEPUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPLEPUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPLEPUDGY>(arg0, 6, b"PURPLEPUDGY", b"Purple Pudgy Ai", b"Purple Pudgy AI is a community-driven meme coin that blends the worlds of cryptocurrency and artificial intelligence. Strap in and enjoy the ride while this Ai Pudgy takes off!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_012142_203_bceaa049a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPLEPUDGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURPLEPUDGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

