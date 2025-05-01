module 0xb086c0f956b185424f89a898eafbf89e69b408ecf639cf1c12d1aac7b8ee468d::inoueyou_sui {
    struct INOUEYOU_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INOUEYOU_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INOUEYOU_SUI>(arg0, 9, b"inoueyouSUI", b"1 Staked SUI", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/dc1df43f-1451-4ffe-9a1d-4bda3fb19da0/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INOUEYOU_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INOUEYOU_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

