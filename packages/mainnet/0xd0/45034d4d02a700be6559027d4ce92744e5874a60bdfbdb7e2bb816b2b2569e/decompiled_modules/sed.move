module 0xd045034d4d02a700be6559027d4ce92744e5874a60bdfbdb7e2bb816b2b2569e::sed {
    struct SED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SED>(arg0, 6, b"SED", b"Sui Eyed Dog", x"537569203d2057617465720a0a5468697320446f6727732065796573206172652074686520636f6c6f7572206f662057617465720a0a54686520636f6c6f7572206f662053756920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_eyed_dog_f677c00656.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SED>>(v1);
    }

    // decompiled from Move bytecode v6
}

