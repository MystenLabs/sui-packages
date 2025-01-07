module 0x5ff7847dafc0e0b0c58948276901f38d50bde4c0e1bf044ab31a5ae9174fae1b::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 6, b"AVATAR", b"AVATARSUI", b"Avatar On This way ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196890_a12568e299.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

