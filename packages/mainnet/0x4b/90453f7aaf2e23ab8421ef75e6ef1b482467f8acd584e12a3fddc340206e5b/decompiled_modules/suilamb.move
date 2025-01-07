module 0x4b90453f7aaf2e23ab8421ef75e6ef1b482467f8acd584e12a3fddc340206e5b::suilamb {
    struct SUILAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMB>(arg0, 6, b"SUILAMB", b"suilamb", b"SUILAMB is definitely the cutest sheep character in Sui Chain. This is the new GOAT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_22_12_36_1f6ae2bc5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

