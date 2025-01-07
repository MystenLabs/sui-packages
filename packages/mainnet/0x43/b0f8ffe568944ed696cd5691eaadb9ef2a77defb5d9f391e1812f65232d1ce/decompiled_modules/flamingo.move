module 0x43b0f8ffe568944ed696cd5691eaadb9ef2a77defb5d9f391e1812f65232d1ce::flamingo {
    struct FLAMINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMINGO>(arg0, 6, b"FLAMINGO", b"FLAMINGO SUI", x"466c616d696e676f204772696e676f20697320746865204b696e67206f6620537569210a412076696272616e74207265616c6d2077686572652074686520736b696573206172652070696e6b20616e642074686520776174657273207368696d6d6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x17c334979cd0698ccf9450a3ec2ae0ce1e4c6b0935353fe5facbf69fa77a72af_flamingo_flamingo_5361e96a3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAMINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

