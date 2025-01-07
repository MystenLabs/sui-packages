module 0x6aa1ff360b1b81ecd6956ab81bfd5464dd505dd78d39f6fb81b51e44d0018ed8::hip {
    struct HIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP>(arg0, 6, b"HIP", b"HIP SUI", b"The most fun hippo you'll ever find is here! along with musical vibes and hippo-sized profits $HIP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_27263dd700.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

