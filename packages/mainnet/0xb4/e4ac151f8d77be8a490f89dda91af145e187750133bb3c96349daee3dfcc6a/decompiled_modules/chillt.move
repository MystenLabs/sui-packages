module 0xb4e4ac151f8d77be8a490f89dda91af145e187750133bb3c96349daee3dfcc6a::chillt {
    struct CHILLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLT>(arg0, 6, b"CHILLT", b"Chill Trump Sui", b"Make Trump Chill Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013895_3aaa78454a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

