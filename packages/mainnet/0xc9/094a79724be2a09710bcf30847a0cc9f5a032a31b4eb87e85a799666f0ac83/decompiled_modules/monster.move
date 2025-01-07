module 0xc9094a79724be2a09710bcf30847a0cc9f5a032a31b4eb87e85a799666f0ac83::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTER>(arg0, 6, b"MONSTER", b"Sui Monster", b"The monster of Sui. Big and strong, but still cute! Dont let the name fool you, he is here to have fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Monster_3645cb1d29.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

