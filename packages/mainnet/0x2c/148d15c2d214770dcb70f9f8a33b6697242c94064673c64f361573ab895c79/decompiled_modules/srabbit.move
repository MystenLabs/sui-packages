module 0x2c148d15c2d214770dcb70f9f8a33b6697242c94064673c64f361573ab895c79::srabbit {
    struct SRABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRABBIT>(arg0, 6, b"Srabbit", b"Sui rabbit", b"The rabbit on sui to make sui more attractive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rabbit_99af3db48c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

