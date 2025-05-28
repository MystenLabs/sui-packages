module 0x7d711ffb59fb2aee0242139d03bd2b7e6eba7cc18cc389742da5630dd57e63d::sharpedo {
    struct SHARPEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARPEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARPEDO>(arg0, 6, b"SHARPEDO", b"Sharpedo on Sui", b"At home in the deep sea depths near the islands off of Huaon, Sharpedo often travels in schools and poses a danger to any traveler whom it sees as a threat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiajdppcd5g3jmzrmhfx4twhqk3wyi5tmzakgmic3redyjuqhefaga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARPEDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARPEDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

