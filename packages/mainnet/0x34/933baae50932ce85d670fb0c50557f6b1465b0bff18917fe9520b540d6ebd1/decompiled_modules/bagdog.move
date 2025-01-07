module 0x34933baae50932ce85d670fb0c50557f6b1465b0bff18917fe9520b540d6ebd1::bagdog {
    struct BAGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGDOG>(arg0, 6, b"BAGDOG", b"BagDog", b"BAGDOG is a meme token inspired by the bag and dog.BAGDOG is ready for an adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_RA_7_D_Xx1m9x4_MJ_Vwo_C7p_Zg5w_L_Dj4_G2_SGU_6_V_Nc9oemk6p_af6f6a706c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

