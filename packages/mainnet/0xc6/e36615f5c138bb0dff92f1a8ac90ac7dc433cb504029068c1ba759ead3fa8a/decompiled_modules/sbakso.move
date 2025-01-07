module 0xc6e36615f5c138bb0dff92f1a8ac90ac7dc433cb504029068c1ba759ead3fa8a::sbakso {
    struct SBAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAKSO>(arg0, 6, b"SBAKSO", b"Welcome Bakso", b"Disney Sumatran Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7398_0fcb3cb16b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

