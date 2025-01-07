module 0x1d3afe9c9b0952113493eeda034c2a5bb23c34aad5bc245edb5091d13001934f::guard {
    struct GUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUARD>(arg0, 6, b"GUARD", b"SuiGuardOnSui", b"Guard -  meme coin is inspired by the brave and strong lifeguards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002163_f1728f7ae4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

