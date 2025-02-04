module 0xd68f3e367b60d04239c536041c5bc9138d252538a51609156c40b1b24c910337::sdom {
    struct SDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOM>(arg0, 6, b"SDOM", b"SUI KINGDOM", b"welcome to SUI KINGDOM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250204_080858_0000_f3242ee3ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

