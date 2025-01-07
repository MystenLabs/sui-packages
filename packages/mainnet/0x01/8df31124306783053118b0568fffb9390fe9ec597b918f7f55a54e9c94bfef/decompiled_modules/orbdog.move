module 0x18df31124306783053118b0568fffb9390fe9ec597b918f7f55a54e9c94bfef::orbdog {
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

