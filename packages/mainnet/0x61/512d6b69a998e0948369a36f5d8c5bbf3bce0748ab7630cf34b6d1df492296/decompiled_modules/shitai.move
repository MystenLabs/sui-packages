module 0x61512d6b69a998e0948369a36f5d8c5bbf3bce0748ab7630cf34b6d1df492296::shitai {
    struct SHITAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITAI>(arg0, 6, b"SHITAI", b"Shit AI Agent", b"shitty ai agent taking shits. shit on shitty devs, shit on shit coins, shitty farmers and shitty rugs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_Sghc_F_Ifv_1737053473381_raw_min_474342dec3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

