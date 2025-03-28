module 0x3267776656db0152b6971bbfce1f3d51286e73dd4214df3aa134a4f402bd108f::niggapump {
    struct NIGGAPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGAPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGAPUMP>(arg0, 6, b"NIGGAPUMP", b"NIGGAPUMP6900X", b"Sol play on sui send this to 100mil and watch the solana guys come over.. thats the plan sui season starts with NIGGAPUMP6900X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3924_3d6905544b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGAPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGAPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

