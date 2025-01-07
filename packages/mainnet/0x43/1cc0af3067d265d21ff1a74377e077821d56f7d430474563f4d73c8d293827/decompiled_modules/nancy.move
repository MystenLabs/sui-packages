module 0x431cc0af3067d265d21ff1a74377e077821d56f7d430474563f4d73c8d293827::nancy {
    struct NANCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANCY>(arg0, 6, b"NANCY", b"Nancy On Sui", b"Reverse the Nancy is Narrative", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047924_299f002a4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NANCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

