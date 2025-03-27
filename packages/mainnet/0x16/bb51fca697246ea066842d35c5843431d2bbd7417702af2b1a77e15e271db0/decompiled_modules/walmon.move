module 0x16bb51fca697246ea066842d35c5843431d2bbd7417702af2b1a77e15e271db0::walmon {
    struct WALMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALMON>(arg0, 6, b"WALMON", b"Walrus Monster", b"Walrus Monster is a unique animal with intelligence and very great search for prey, and this time it is the monster Walrus that will rule the entire universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076299_5f34df1033.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

