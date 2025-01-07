module 0x193a5fa8050fbb156dc4992f6a7a7d288a54a5f464bbd5f9ef33db6840d4c941::spank {
    struct SPANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPANK>(arg0, 6, b"SPANK", b"Spank That Bitch", b"We spankin' all day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_1_771e6316dc_3c2e1a1f6a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

