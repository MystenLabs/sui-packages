module 0x61cd4e5cc10f83ba545515439c2f7220a36005790e7dfad02b03a95964d6773a::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"Cook", b"Let him cook", b"Test, do not buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3330_24dc9b3b56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

