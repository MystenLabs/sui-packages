module 0x82150cc6638d4ed1c78ec1d8524320368127bcebb00c9b5f6aedf29f6cc18994::kinggg {
    struct KINGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGGG>(arg0, 6, b"KINGGG", b"KINGGGSUI", b"BOW TO YOUR KING  AND HE WILL BRING YOU THE GLORY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GI_yc_SRWYA_Acf_a_copy_2_1ecf25b855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

