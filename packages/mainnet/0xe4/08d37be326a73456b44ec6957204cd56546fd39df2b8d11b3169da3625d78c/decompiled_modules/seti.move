module 0xe408d37be326a73456b44ec6957204cd56546fd39df2b8d11b3169da3625d78c::seti {
    struct SETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETI>(arg0, 6, b"SETI", b"SUISETI", b"Mythical Beast Here To Slay All Bears", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_Xf_Vr_OQ_400x400_9261c63b6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

