module 0x4ba8df7ecdf1083492438163779bd1f7437e4233f913f10d4d6ef7c353163e04::texas {
    struct TEXAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXAS>(arg0, 6, b"Texas", b"Texas Perro", b"Texas, ngmi number one cocksucker, he will suck his tiny dick for make him happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5607_0f7d825741.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEXAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

