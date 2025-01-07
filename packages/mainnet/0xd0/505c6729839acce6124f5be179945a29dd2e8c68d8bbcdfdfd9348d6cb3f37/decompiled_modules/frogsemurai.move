module 0xd0505c6729839acce6124f5be179945a29dd2e8c68d8bbcdfdfd9348d6cb3f37::frogsemurai {
    struct FROGSEMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGSEMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGSEMURAI>(arg0, 6, b"FROGSEMURAI", b"Frodo the Virtual Samurai", b"Frodo the Virtual Samurai is Just a friendly $FROG on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/63456_61f266fc1c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGSEMURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGSEMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

