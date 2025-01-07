module 0xc578250bf5b9ad91d01a9356b01c4123c41676a44e166bb018893cb20b04d2bf::jim {
    struct JIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIM>(arg0, 6, b"JIM", b"Jim Pinkman", b"Think Pink, Swing Big!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_ZO_9_O_Ba_X_400x400_1_f3e124ec59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

