module 0x7a30c7159f76a49544bcb3988f4117da3c310b3005723b4c00fd270b93781b6b::osep {
    struct OSEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSEP>(arg0, 6, b"OSEP", b"Ostrich Pepe", b"Imagine an ostrich with a tall, strong body, powerful legs, and the characteristic black and white feathers. But instead of a regular face, it has the face of Pepe the Frog - a green frog with big, round eyes and a variety of expressions. This face can show many different emotions, from happiness and sadness to smugness or anger, just like the famous Pepe memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6f756ddc3414eb62e28c56fc5570bea5271872fc504f5df5ce5a52a343270c29_osep_osep_9e483de64a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

