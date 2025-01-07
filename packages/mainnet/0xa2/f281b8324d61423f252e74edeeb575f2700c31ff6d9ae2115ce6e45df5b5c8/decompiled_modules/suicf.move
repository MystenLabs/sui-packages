module 0xa2f281b8324d61423f252e74edeeb575f2700c31ff6d9ae2115ce6e45df5b5c8::suicf {
    struct SUICF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICF>(arg0, 6, b"SUICF", b"SMOKING CHICKEN FISH", b"Smoking chicken fish sui, financial freedom increase bean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1461728887562_pic_e4592dc5f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICF>>(v1);
    }

    // decompiled from Move bytecode v6
}

