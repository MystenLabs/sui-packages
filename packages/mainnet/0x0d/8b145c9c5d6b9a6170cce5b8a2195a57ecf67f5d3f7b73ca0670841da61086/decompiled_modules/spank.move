module 0xd8b145c9c5d6b9a6170cce5b8a2195a57ecf67f5d3f7b73ca0670841da61086::spank {
    struct SPANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPANK>(arg0, 6, b"SPANK", b"Spank That Bitch", b"We spankin' all day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_1_771e6316dc_f50741fcd1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

