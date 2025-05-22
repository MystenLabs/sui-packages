module 0x735547e02038dc0b950186ef91881033688591cc349904dd48b36459ee021ab::suinny {
    struct SUINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNY>(arg0, 6, b"Suinny", b"Sui-nny Go!", b"A por el Sui Piece!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747940897691.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

