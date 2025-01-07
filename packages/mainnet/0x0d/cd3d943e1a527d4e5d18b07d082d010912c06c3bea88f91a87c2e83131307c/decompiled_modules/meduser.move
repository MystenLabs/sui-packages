module 0xdcd3d943e1a527d4e5d18b07d082d010912c06c3bea88f91a87c2e83131307c::meduser {
    struct MEDUSER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSER>(arg0, 6, b"MEDUSER", b"MEDUSA ON SUI", b"The Talking Ai ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2142_2d834a99a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSER>>(v1);
    }

    // decompiled from Move bytecode v6
}

