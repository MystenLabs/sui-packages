module 0x2ab2d1f89d0bf6e19ad128c052076ef8ec3473799ccb39e7ed08e5b8a85264d0::kainu {
    struct KAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAINU>(arg0, 6, b"KAINU", b"Kai Inu", b"The Kai Inu, inspired by the rare and ancient Tiger Dog of Japan's rugged mountains, embodies the strength, agility, and stealth of this elusive breed. Just as the brindle coat of the Kai Inu blends seamlessly into its surroundings, this coin holds the power to move swiftly and subtly within the digital ecosystem of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kainu_e8e38c5a5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

