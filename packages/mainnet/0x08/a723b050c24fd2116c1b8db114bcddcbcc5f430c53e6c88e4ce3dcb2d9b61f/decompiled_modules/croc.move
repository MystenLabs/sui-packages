module 0x8a723b050c24fd2116c1b8db114bcddcbcc5f430c53e6c88e4ce3dcb2d9b61f::croc {
    struct CROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROC>(arg0, 6, b"CROC", b"King Crocodile", b"Introducing King Crocodile, the ultimate crypto meme token! Celebrate the world's coolest reptiles, known for their chill vibes and killer style. Join the $CROC club and let's make some waves together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726310110036_8d3090127e07227b1312434beeb9c60e_dc4a3d5262.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

