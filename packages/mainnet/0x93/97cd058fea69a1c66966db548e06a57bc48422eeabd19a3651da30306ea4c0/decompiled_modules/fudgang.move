module 0x9397cd058fea69a1c66966db548e06a57bc48422eeabd19a3651da30306ea4c0::fudgang {
    struct FUDGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGANG>(arg0, 6, b"FUDGANG", b"Fuddies Gang", b"FUGANG is the AI coin and meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/17e4fef22b278ecbdc6af0baf931a791c59a4d29f67260d1379849a09175c118_d3e729d85b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

