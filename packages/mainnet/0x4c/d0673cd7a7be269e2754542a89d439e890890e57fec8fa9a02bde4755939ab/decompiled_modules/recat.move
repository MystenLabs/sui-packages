module 0x4cd0673cd7a7be269e2754542a89d439e890890e57fec8fa9a02bde4755939ab::recat {
    struct RECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RECAT>(arg0, 6, b"RECAT", b"Resistance Cat", b"$Recat- The coolest cat on Sui fighting freedom. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9273_01676dc171.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

