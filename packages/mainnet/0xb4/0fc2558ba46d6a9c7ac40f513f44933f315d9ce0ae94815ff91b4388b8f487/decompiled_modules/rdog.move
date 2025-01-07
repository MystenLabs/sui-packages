module 0xb40fc2558ba46d6a9c7ac40f513f44933f315d9ce0ae94815ff91b4388b8f487::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOG>(arg0, 6, b"RDOG", b"Report Dog", b"Following repost dog Now is a chance for Report Dog! We need Report Dog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_L_Ec_U_Ec_V_Tz9_HH_Ykcmy_Rf_Jivwyv_TWABT_Chh4gff5_N169s_5a03970d75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

