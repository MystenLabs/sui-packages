module 0xd88ac5a42b6f46f47b4c58156cc13c6d0684964b398287ec718ba724dc6eccb3::erbai {
    struct ERBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERBAI>(arg0, 6, b"ERBAI", b"$ERBAI, the first AI robot", b"$ERBAI, the first AI robot caught in a attempted kidnapping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/airobot_e0a9da222e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

