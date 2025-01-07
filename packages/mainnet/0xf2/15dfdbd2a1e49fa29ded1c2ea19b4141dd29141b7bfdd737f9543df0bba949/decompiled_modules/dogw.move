module 0xf215dfdbd2a1e49fa29ded1c2ea19b4141dd29141b7bfdd737f9543df0bba949::dogw {
    struct DOGW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGW>(arg0, 6, b"DOGW", b"DogwOnSui", b"Meet $DOG, the ultimate meme coin inspired by Sergeant Stubby, the heroic war dog of World War I, an inductee of the Dogs of War Hall of fame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001044_fe7a3f6f31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGW>>(v1);
    }

    // decompiled from Move bytecode v6
}

