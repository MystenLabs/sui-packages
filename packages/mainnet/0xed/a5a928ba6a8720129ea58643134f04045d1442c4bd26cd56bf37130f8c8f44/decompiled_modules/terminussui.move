module 0xeda5a928ba6a8720129ea58643134f04045d1442c4bd26cd56bf37130f8c8f44::terminussui {
    struct TERMINUSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUSSUI>(arg0, 6, b"TERMINUSsui", b"TERMINUS", b"TERMINUS in Sui now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3364_a33f14c038.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINUSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

