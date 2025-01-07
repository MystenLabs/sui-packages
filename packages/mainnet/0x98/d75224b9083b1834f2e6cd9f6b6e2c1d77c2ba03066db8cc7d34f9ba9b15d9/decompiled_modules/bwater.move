module 0x98d75224b9083b1834f2e6cd9f6b6e2c1d77c2ba03066db8cc7d34f9ba9b15d9::bwater {
    struct BWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWATER>(arg0, 6, b"BWATER", b"Brett in the water", b"In Sui universe, Brett became the guardians of Sui, with the power to communicate with Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brett_245a14fcbf_54ec2e2772.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

