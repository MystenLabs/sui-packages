module 0x8f783310f339b0892586a3230ace30186043529d3253260d09f215e3353677d::flamingo {
    struct FLAMINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMINGO>(arg0, 6, b"FLAMINGO", b"FLAMINGO GRINGO", x"466c616d696e676f204772696e676f202c204b696e67206f662024535549200a0a204a6f696e206d79204b696e67646f6d2c20616e642062652070617274206f662074686520436f6d6d756e6974793a2068747470733a2f2f742e6d652f666c616d696e676f5f737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flamingo_fb22a99f27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAMINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

