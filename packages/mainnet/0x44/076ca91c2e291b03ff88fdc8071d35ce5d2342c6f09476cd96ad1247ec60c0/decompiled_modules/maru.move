module 0x44076ca91c2e291b03ff88fdc8071d35ce5d2342c6f09476cd96ad1247ec60c0::maru {
    struct MARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARU>(arg0, 6, b"MARU", b"MARU TARO", b"MARU TARO THE FAMOUS SHIBA INU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E64_FDC_0_D_9_C9_E_4603_901_F_5_DAF_10_CBC_449_4a42e08057.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

