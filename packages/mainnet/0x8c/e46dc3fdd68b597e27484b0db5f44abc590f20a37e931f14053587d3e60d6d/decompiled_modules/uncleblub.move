module 0x8ce46dc3fdd68b597e27484b0db5f44abc590f20a37e931f14053587d3e60d6d::uncleblub {
    struct UNCLEBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNCLEBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNCLEBLUB>(arg0, 6, b"UNCLEBLUB", b"UNCLE BLUB", b"Uncle of the BLUB. The baddest king of the ocean! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uncle_blub_b42c4b3a94.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNCLEBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNCLEBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

