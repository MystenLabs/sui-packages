module 0xa71d42b3519e4bec3eb985a916b12ee76dc5ab3c751f9acecb3ba6bb46bd2b76::orbdog {
    struct ORBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBDOG>(arg0, 6, b"Orbdog", b"Orbeez Dog", b"$Orbdog is the most daring dog on the blockchain. He only eats Orbeez and Jeets, and the occasional bacon egg & cheese sandwich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_3ad4c60776.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

