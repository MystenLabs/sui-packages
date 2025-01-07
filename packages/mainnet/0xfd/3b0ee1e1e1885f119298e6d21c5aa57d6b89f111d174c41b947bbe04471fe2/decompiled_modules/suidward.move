module 0xfd3b0ee1e1e1885f119298e6d21c5aa57d6b89f111d174c41b947bbe04471fe2::suidward {
    struct SUIDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDWARD>(arg0, 6, b"SUIDWARD", b"SUIDWARD SUIRPANTS", b"I Have No Soul Of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_suidward_39f594a070.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

