module 0xcb7c46905da3972cb0a5d046d6f20f69028529b97b302593e06d310e836c6b7d::dake {
    struct DAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAKE>(arg0, 6, b"Dake", b"Dake Sui", b"Dake journey has begun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeictya47w7jhs2kp5n5l45u3lquas3xasoxf5shnwi65coxjgtf46m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

