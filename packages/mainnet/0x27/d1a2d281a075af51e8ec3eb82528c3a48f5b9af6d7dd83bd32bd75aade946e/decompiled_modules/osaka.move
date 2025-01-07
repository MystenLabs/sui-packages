module 0x27d1a2d281a075af51e8ec3eb82528c3a48f5b9af6d7dd83bd32bd75aade946e::osaka {
    struct OSAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAKA>(arg0, 6, b"Osaka", b"Osaka SUI", b"Osaka now live on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOG_Ooaska_f37ccb1933.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

