module 0xe564f2be24a4b162259cfad79f04434f91d6157dc2de0a10d5d832b41feb55a7::mcs {
    struct MCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCS>(arg0, 6, b"MCS", b"Marlboro Cat on Sui", b"Marlboro Cat on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1135_fbaa689a97.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

