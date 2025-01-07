module 0x83fd02064b028b72742d563be5384720ee61f587d276aa472d17c5ac56559d75::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"HAMSTER", b"Hamster Sui", b"HamsterSui may be small, but its designed to offer huge potential returns for its holders. Join : hamstersui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6af34706dc35c260c6ba540c9f49f7a7_7bd32daa39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

