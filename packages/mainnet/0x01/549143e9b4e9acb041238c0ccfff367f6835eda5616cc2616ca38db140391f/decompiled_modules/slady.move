module 0x1549143e9b4e9acb041238c0ccfff367f6835eda5616cc2616ca38db140391f::slady {
    struct SLADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLADY>(arg0, 6, b"SLADY", b"SUILADY", b"The Brightest Cult on Hyperliquid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tonlady_75121496db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

