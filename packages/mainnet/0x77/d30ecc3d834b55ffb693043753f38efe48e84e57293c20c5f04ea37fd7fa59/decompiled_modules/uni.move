module 0x77d30ecc3d834b55ffb693043753f38efe48e84e57293c20c5f04ea37fd7fa59::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"UNI THE WONDER DOG", x"556e69206973206120204d656d65636f696e206261736564206f6e2053756920666f756e646572277320646f67200a0a3130302520636f6d6d756e6974792064726976656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/121212121212_038ad053fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

