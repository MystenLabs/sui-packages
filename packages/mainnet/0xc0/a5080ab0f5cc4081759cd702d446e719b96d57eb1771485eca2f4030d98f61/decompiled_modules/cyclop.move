module 0xc0a5080ab0f5cc4081759cd702d446e719b96d57eb1771485eca2f4030d98f61::cyclop {
    struct CYCLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYCLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYCLOP>(arg0, 6, b"CYCLOP", b"cyclop", b"Crypto trader & angel investor  No paid groups/courses  Follow for free educational content ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J5e4cyy_V_400x400_292b7d8289.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYCLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYCLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

