module 0x86a234449b31421a22b6ce1f3150ccd71aad433ab22183909a8e0825d67497dd::bender {
    struct BENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENDER>(arg0, 6, b"BENDER", b"SUIBENDER", b"The Last SuiBender", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mascotx_a356c87586.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

