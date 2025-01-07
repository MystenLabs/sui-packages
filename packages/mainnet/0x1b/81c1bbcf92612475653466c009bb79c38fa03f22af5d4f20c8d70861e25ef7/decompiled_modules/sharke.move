module 0x1b81c1bbcf92612475653466c009bb79c38fa03f22af5d4f20c8d70861e25ef7::sharke {
    struct SHARKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKE>(arg0, 6, b"SHARKE", b"Sharke", b"hi Im Sharke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_3351664c1f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

