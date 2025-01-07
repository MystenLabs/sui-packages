module 0x45f003145f883d36885051b4f343e9ff4b322c68b0dc62b947d881816bd32068::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"FirstPupOfSui", b"First pup of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uni_logo_256_7329de5fdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

