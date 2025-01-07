module 0x33e9824bcb349fff8c563a5f5dfe8f07551f930bdea4085bf40290f121cf9a7d::fbd {
    struct FBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBD>(arg0, 6, b"FBD", b"Flying Bull Dragon", b"Million Dollar Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SPQPG_87do_J7_KE_8_SLV_Zie_Ja_K97_Ug_Kgk_Fdpk_Mqr68_W1d88_310e644c99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

