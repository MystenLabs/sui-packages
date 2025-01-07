module 0x3cd5ef805dcd65b5d33d1f591797d834f556f34c00f3736534da3d7991d886b::suicrocodiles {
    struct SUICROCODILES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICROCODILES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICROCODILES>(arg0, 6, b"SUICROCODILES", b"SuiCrocodiles", b"Introducing King Crocodile, the ultimate crypto meme token! Celebrate the world's coolest reptiles, known for their chill vibes and killer style. Join the $CROC club and let's make some waves together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_09_25_19_0b801099a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICROCODILES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICROCODILES>>(v1);
    }

    // decompiled from Move bytecode v6
}

