module 0x6f22a71b12a363a214b45f495fd8887c11314fe991256af4c494f0c75d383205::argu {
    struct ARGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARGU>(arg0, 6, b"ARGU", b"Argu Sui", x"313531313131462070737963686f20617274697374202f206169202f2064657620206469676974616c206465737472756374696f6e200a4149206d616b696e672041492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vrh_J_Mj_PZ_400x400_cda5cc8807.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

