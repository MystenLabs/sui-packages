module 0x77db85ca5eb7b09d8ad93a4d9a7df5d395ce099a6dd90c40f05af9932d4a7002::bwater {
    struct BWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWATER>(arg0, 6, b"BWATER", b"Brett in the water", b"In Sui universe, Brett became the guardians of Sui, with the power to communicate with Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brett_245a14fcbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

