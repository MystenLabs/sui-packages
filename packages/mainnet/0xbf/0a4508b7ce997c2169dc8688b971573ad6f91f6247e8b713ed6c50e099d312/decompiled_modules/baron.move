module 0xbf0a4508b7ce997c2169dc8688b971573ad6f91f6247e8b713ed6c50e099d312::baron {
    struct BARON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARON>(arg0, 6, b"Baron", b"Baron Memecoin", x"5468652044697374696e677569736865642047656e746c656d616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zl_Sm_Dm_LF_400x400_503be3ab73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARON>>(v1);
    }

    // decompiled from Move bytecode v6
}

