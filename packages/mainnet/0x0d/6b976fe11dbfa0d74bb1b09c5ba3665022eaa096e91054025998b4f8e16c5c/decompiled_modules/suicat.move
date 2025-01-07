module 0xd6b976fe11dbfa0d74bb1b09c5ba3665022eaa096e91054025998b4f8e16c5c::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"Sui Cat", b"The one and only official cat of the Sui network. First, original, and full of attitude.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_6e0e615592.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

