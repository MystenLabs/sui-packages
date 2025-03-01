module 0x80310c86d7711121a33732473707e37ed300e4f60ec1c1e3aa82f2580e591682::armaged {
    struct ARMAGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARMAGED>(arg0, 6, b"ARMAGED", b"ARMAGEDDON", b"HODL on until the world ends...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Armageddon_3f743ed67f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMAGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARMAGED>>(v1);
    }

    // decompiled from Move bytecode v6
}

