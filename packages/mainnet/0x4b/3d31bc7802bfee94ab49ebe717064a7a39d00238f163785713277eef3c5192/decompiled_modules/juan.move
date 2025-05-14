module 0x4b3d31bc7802bfee94ab49ebe717064a7a39d00238f163785713277eef3c5192::juan {
    struct JUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUAN>(arg0, 6, b"JUAN", b"Juan Cena", b"You cant see me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7204_09bec3d709.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

