module 0x84b73e2a3687e9ec317de0ff89e1eefc550c82ceef4881cfb02f09b44d629139::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 6, b"AVATAR", b"Avatar", x"415641544152535549204f4e20484953205741590a546865206c6173742061697262656e64657220696e207468652063727970746f20776f726c640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038682_1f6fb7696a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

