module 0xd177f070ac9dc7ca9cf13107ff9bebc74b4606ab75dde706e9a6bfa78377de23::nsell {
    struct NSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSELL>(arg0, 6, b"NSELL", b"i'm not selling", b"i'm not selling memes on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Wy5_WU_5_WMA_Asl_HI_b12d15da26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

