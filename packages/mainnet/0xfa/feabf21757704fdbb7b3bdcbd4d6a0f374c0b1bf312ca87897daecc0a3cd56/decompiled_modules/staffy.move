module 0xfafeabf21757704fdbb7b3bdcbd4d6a0f374c0b1bf312ca87897daecc0a3cd56::staffy {
    struct STAFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAFFY>(arg0, 6, b"STAFFY", b"Sui Staffy", b"Staffy - The epitome of loyalty, strength, and charm, just like its namesake, the Staffordshire Bull Terrier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012576_98addd6f8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

