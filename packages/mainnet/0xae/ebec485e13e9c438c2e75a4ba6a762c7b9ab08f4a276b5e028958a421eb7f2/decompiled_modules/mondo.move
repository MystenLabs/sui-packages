module 0xaeebec485e13e9c438c2e75a4ba6a762c7b9ab08f4a276b5e028958a421eb7f2::mondo {
    struct MONDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONDO>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"MONDO", b"Armand Duplantis", b"The LP coin for the Duplantis Vault.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyoWjOmtJoebYmnDgJtKxwz6kMdNW2iK9QMw&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

