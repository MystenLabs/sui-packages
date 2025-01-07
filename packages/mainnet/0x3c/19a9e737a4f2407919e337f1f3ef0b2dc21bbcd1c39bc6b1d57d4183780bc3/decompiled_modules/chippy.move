module 0x3c19a9e737a4f2407919e337f1f3ef0b2dc21bbcd1c39bc6b1d57d4183780bc3::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"CHIPPY SUI", b"Official Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5609_5c7afc58bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

